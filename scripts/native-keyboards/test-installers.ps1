$ErrorActionPreference='Stop'
Add-Type @'
using System;
using System.Text;
using System.Runtime.InteropServices;
public static class LayoutDisplayName {
 [DllImport("kernel32.dll",CharSet=CharSet.Unicode,SetLastError=true)] static extern IntPtr LoadLibraryEx(string path,IntPtr file,uint flags);
 [DllImport("user32.dll",CharSet=CharSet.Unicode)] static extern int LoadString(IntPtr module,uint id,StringBuilder text,int capacity);
 [DllImport("kernel32.dll")] static extern bool FreeLibrary(IntPtr module);
 public static string Read(string path) {
   IntPtr module=LoadLibraryEx(path,IntPtr.Zero,0x22);
   if(module==IntPtr.Zero) throw new Exception("Cannot read layout resources: "+path);
   try {
     var text=new StringBuilder(512);
     if(LoadString(module,1000,text,text.Capacity)==0) throw new Exception("Missing keyboard display name: "+path);
     return text.ToString();
   } finally {FreeLibrary(module);}
 }
}
'@
$repo=[IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
$layouts=Get-Content (Join-Path $PSScriptRoot 'layouts.json') -Raw | ConvertFrom-Json
$version=[string](Get-Content (Join-Path $PSScriptRoot 'version.json') -Raw -Encoding UTF8 | ConvertFrom-Json).version
$installer=New-Object -ComObject WindowsInstaller.Installer
$codes=@{}
$checks=0
foreach($layout in $layouts) {
    $dir=Join-Path $repo ('outputs\native-keyboards\'+$layout.slug)
    foreach($suffix in @('_i386.msi','_amd64.msi')) {
        $db=$installer.OpenDatabase((Join-Path $dir ($layout.name+$suffix)),0)
        $properties=@{}
        $view=$db.OpenView('SELECT `Property`,`Value` FROM `Property`')
        $view.Execute()
        while($rec=$view.Fetch()) {$properties[$rec.StringData(1)]=$rec.StringData(2)}
        $view.Close()
        if($properties.ProductName -ne $layout.title){throw 'Wrong installer name'}
        if($properties.LayoutFile -ne ($layout.name+'.dll')){throw 'Wrong layout DLL'}
        if($properties.LCIDValue -ne ([Globalization.CultureInfo]$layout.locale).LCID.ToString('x4')){throw 'Wrong input locale'}
        if($codes.ContainsKey($properties.ProductCode) -and $codes[$properties.ProductCode] -ne $layout.name){throw 'Product code collision'}
        $codes[$properties.ProductCode]=$layout.name
        $view=$db.OpenView('SELECT `Component`,`Condition` FROM `Component`')
        $view.Execute()
        $conditions=@()
        while($rec=$view.Fetch()) {if($rec.StringData(2)){$conditions+=$rec.StringData(2)}}
        $view.Close()
        foreach($condition in @('NOT VersionNT64','Msix64','Intel64','VersionNT64')) {
            if($condition -notin $conditions){throw 'Missing architecture condition'}
        }
        $checks++
        [void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($view)
        [void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($db)
    }
    foreach($arch in @(@('i386',0x14c),@('amd64',0x8664),@('wow64',0x14c))) {
        $bytes=[IO.File]::ReadAllBytes((Join-Path $dir ($arch[0]+'\'+$layout.name+'.dll')))
        $pe=[BitConverter]::ToInt32($bytes,60)
        if([BitConverter]::ToUInt16($bytes,$pe+4) -ne $arch[1]){throw 'Wrong PE architecture'}
        $checks++
        $displayName=[LayoutDisplayName]::Read((Join-Path $dir ($arch[0]+'\'+$layout.name+'.dll')))
        if($displayName -ne $layout.title){throw ('Wrong Windows selector name: '+$layout.slug+' '+$arch[0]+' '+$displayName)}
        $checks++
    }
    if(-not (Test-Path -LiteralPath (Join-Path $dir 'setup.exe'))){throw 'Missing executable installer'}
    $setupBytes=[IO.File]::ReadAllBytes((Join-Path $dir 'setup.exe'))
    if(-not [Text.Encoding]::UTF8.GetString($setupBytes).Contains('level="asInvoker"')){throw 'Setup must run as the initiating user'}
    $assembly=[Reflection.Assembly]::Load($setupBytes)
    $reader=[IO.StreamReader]::new($assembly.GetManifestResourceStream('setup-config.json'))
    try{$config=$reader.ReadToEnd() | ConvertFrom-Json}finally{$reader.Dispose()}
    if($config.version -ne $version -or $config.layout.name -ne $layout.name -or $config.layout.locale -ne $layout.locale -or $config.layout.title -ne $layout.title){throw 'Wrong setup identity or version'}
    $versionInfo=[Diagnostics.FileVersionInfo]::GetVersionInfo((Join-Path $dir 'setup.exe'))
    if($versionInfo.FileVersion -ne ($version+'.0') -or $versionInfo.ProductVersion -ne $version){throw 'Wrong executable version metadata'}
    $checks++
    foreach($language in @('es','en','fr','de','it','pt','nb','da','ru','uk','be')){
        foreach($key in $config.texts.en.PSObject.Properties.Name){
            if(-not $config.texts.$language.$key){throw ('Missing setup translation: '+$language+' '+$key)}
        }
    }
    foreach($resource in @('setup-core.ps1','setup-ui.ps1','setup-msi.ps1')){
        $reader=[IO.StreamReader]::new($assembly.GetManifestResourceStream($resource))
        try{$embedded=$reader.ReadToEnd()}finally{$reader.Dispose()}
        if($embedded -cne [IO.File]::ReadAllText((Join-Path $PSScriptRoot $resource))){throw 'Stale embedded setup script'}
    }
    $checks+=5
}
[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($installer)
@{passed=$true;installerAndArchitectureChecks=$checks;uniqueProducts=$codes.Count;installed=$false} | ConvertTo-Json | Set-Content (Join-Path $repo 'work\native-keyboards\validation-installers.json') -Encoding UTF8
Write-Output ('PASSED: '+$checks+' installer metadata and architecture checks')
