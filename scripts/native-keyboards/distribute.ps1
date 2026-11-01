$ErrorActionPreference='Stop'
$repo=[IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
$out=Join-Path $repo 'outputs\native-keyboards'
$downloads=Join-Path $repo 'outputs\native-keyboards-downloads'
New-Item -ItemType Directory -Path $downloads -Force | Out-Null
$layouts=Get-Content (Join-Path $PSScriptRoot 'layouts.json') -Raw | ConvertFrom-Json
$locales=Get-Content (Join-Path $PSScriptRoot 'locales.json') -Raw -Encoding UTF8 | ConvertFrom-Json
& (Join-Path $PSScriptRoot 'audit-changes.ps1')
$audits=Get-Content (Join-Path $repo 'work\native-keyboards\character-changes.json') -Raw -Encoding UTF8 | ConvertFrom-Json
$languages=@{
    'Spanish-Spain'='es';'Spanish-Latin-America'='es';'Italian'='it';'Russian'='ru';
    'Ukrainian'='uk';'Belarusian'='be';'Belgian-French'='fr';'Portuguese-Portugal'='pt';
    'Swiss-French'='fr';'Swiss-German'='de';'Luxembourg-Swiss-French'='fr';
    'Norwegian'='no';'German-Germany'='de';'German-Austria'='de';'Danish'='da';
    'English-United-States'='en';'English-United-Kingdom'='en'
}
$utf8=[Text.UTF8Encoding]::new($true)
$practiceSource=Join-Path $PSScriptRoot 'practice'
Copy-Item -LiteralPath $practiceSource -Destination $out -Recurse -Force
foreach($destination in @($out)+@($layouts | ForEach-Object {Join-Path $out $_.slug})){
    Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'LICENSE.template') -Destination (Join-Path $destination 'LICENSE') -Force
    Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'THIRD_PARTY_NOTICES.template.md') -Destination (Join-Path $destination 'THIRD_PARTY_NOTICES.md') -Force
}
foreach($layout in $layouts) {
    $text=$locales.($languages[$layout.slug])
    $practiceLanguage=if($layout.slug -eq 'Swiss-German'){'de-CH'}else{$languages[$layout.slug]}
    Copy-Item -LiteralPath (Join-Path $practiceSource ($practiceLanguage+'.txt')) -Destination (Join-Path $out ($layout.slug+'\practice.txt')) -Force
    $localPractice=Join-Path $out ($layout.slug+'\practice')
    New-Item -ItemType Directory -Path $localPractice -Force | Out-Null
    foreach($exercise in @('short.txt','medium.txt','long.txt')){
        Copy-Item -LiteralPath (Join-Path $practiceSource ($practiceLanguage+'\'+$exercise)) -Destination (Join-Path $localPractice $exercise) -Force
    }
    $audit=$audits | Where-Object layout -eq $layout.slug
    $rows=foreach($change in $audit.changes){
        $previous=if($change.old){[string][char][Convert]::ToInt32($change.old,16)}else{$text.empty}
        'AltGr+'+$change.key+': '+$previous+' → '+[char][Convert]::ToInt32($change.new,16)
    }
    $notes=New-Object 'Collections.Generic.List[string]'
    if($layout.PSObject.Properties['experimental'] -and $layout.experimental){$notes.Add($text.experimental)}
    if(@($audit.changes | Where-Object old -eq '20ac').Count){
        if(-not @($audit.changes | Where-Object old -eq '20ac')[0].alternatives.Contains('scan12/mod6')){throw 'Euro shortcut not verified'}
        $notes.Add($text.euro)
    }
    if(-not @($audit.changes | Where-Object old -ne '').Count){$notes.Add($text.none)}
    if($layout.slug -eq 'Belgian-French'){
        if(-not $audit.changes[0].alternatives.Contains('scan1a/mod6')){throw 'Belgian bracket shortcut not verified'}
        $notes.Add($text.belgian)
    }
    if($layout.slug -in @('Swiss-French','Swiss-German','Luxembourg-Swiss-French')){$notes.Add($text.swiss)}
    if($layout.slug -eq 'Luxembourg-Swiss-French'){$notes.Add($text.lux)}
    if($layout.slug -eq 'German-Austria'){$notes.Add($text.austria)}
    if($layout.slug -in @('Spanish-Latin-America','Italian','Ukrainian','Portuguese-Portugal')){$notes.Add($text.variant)}
    $content=@($layout.title,$text.intro,$text.changes,($rows -join "`r`n"),($notes -join "`r`n"),$text.install,$text.practice,$text.limits) -join "`r`n`r`n"
    [IO.File]::WriteAllText((Join-Path $out ($layout.slug+'\README.txt')),($content -replace "`r?`n","`n")+"`n",$utf8)
}
$oldReadme=Join-Path $out 'READ_ME_FIRST.txt'
if(Test-Path -LiteralPath $oldReadme){Remove-Item -LiteralPath $oldReadme}
New-Item -ItemType Directory -Path (Join-Path $out 'docs') -Force | Out-Null
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'BUILD.template.md') -Destination (Join-Path $out 'docs\BUILD.md') -Force
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'CONTRIBUTING.template.md') -Destination (Join-Path $out 'CONTRIBUTING.md') -Force
& (Join-Path $PSScriptRoot 'generate-readmes.ps1') -OutputRoot $out
& (Join-Path $PSScriptRoot 'generate-release-notes.ps1') -OutputRoot (Join-Path $out 'docs')
Add-Type -AssemblyName System.IO.Compression.FileSystem
Add-Type -AssemblyName System.IO.Compression
function Write-PackageZip([string]$Source,[string]$Destination) {
    if(Test-Path -LiteralPath $Destination){Remove-Item -LiteralPath $Destination -Force}
    $archive=[IO.Compression.ZipFile]::Open($Destination,[IO.Compression.ZipArchiveMode]::Create)
    try {
        $folderName=Split-Path -Leaf $Source
        foreach($file in Get-ChildItem -LiteralPath $Source -Recurse -File){
            $relative=$file.FullName.Substring($Source.Length+1).Replace('\','/')
            $entry=$archive.CreateEntry(($folderName+'/'+$relative),[IO.Compression.CompressionLevel]::Optimal)
            $inputStream=[IO.File]::OpenRead($file.FullName);$outputStream=$entry.Open()
            try{$inputStream.CopyTo($outputStream)}finally{$inputStream.Dispose();$outputStream.Dispose()}
        }
    }finally{$archive.Dispose()}
}
$hashes=[ordered]@{}
foreach($file in Get-ChildItem -LiteralPath $out -Recurse -File) {
    if($file.Extension -eq '.ahk' -or $file.Name -match 'AutoHotkey'){throw 'Unexpected legacy dependency'}
    $relative=$file.FullName.Substring($out.Length+1)
    $hashes[$relative]=(Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash
}
$hashes | ConvertTo-Json | Set-Content (Join-Path $repo 'work\native-keyboards\SHA256.json') -Encoding UTF8
foreach($layout in $layouts) {
    $zip=Join-Path $downloads ($layout.slug+'.zip')
    Write-PackageZip (Join-Path $out $layout.slug) $zip
}
$all=Join-Path $repo 'outputs\ANGLE_QUOTES_NATIVE_WINDOWS.zip'
Write-PackageZip $out $all
Write-Output $all
