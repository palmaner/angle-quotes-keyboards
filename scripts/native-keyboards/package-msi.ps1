param([string]$BuildRoot,[string]$Name,[string]$Title,[string]$Locale)
$ErrorActionPreference='Stop'
[Threading.Thread]::CurrentThread.CurrentUICulture=[Globalization.CultureInfo]'en-US'
Add-Type -AssemblyName System.Windows.Forms
$a=[Reflection.Assembly]::LoadFile('C:\Program Files (x86)\Microsoft Keyboard Layout Creator 1.4\MSKLC.exe')
$flags=[Reflection.BindingFlags]'Public,NonPublic,Instance,Static'
$t=$a.GetType('Microsoft.Globalization.Tools.KeyboardLayoutCreator.Keyboard')
$keyboard=$t.GetConstructors($flags)[0].Invoke([object[]]@([string[]]@(),$true))
$values=@{m_stName=$Name;m_stDescription=$Title;m_stCompany='Javier';m_stVersion='1.0';m_ci=[Globalization.CultureInfo]$Locale;m_fAutomatedBuild=$true}
foreach($key in $values.Keys) { $t.GetField($key,$flags).SetValue($keyboard,$values[$key]) }
$bt=$a.GetType('Microsoft.Globalization.Tools.KeyboardLayoutCreator.DoIt')
$logFile=[string](Join-Path $BuildRoot ($Name+'-package.log'))
$bldr=$bt.GetConstructors($flags)[0].Invoke([object[]]@($logFile))
foreach($p in @{Name=$Name;BuiltFileName=($Name+'.dll');Company='Javier';Description=$Title}.GetEnumerator()) { $bt.GetProperty($p.Key,$flags).SetValue($bldr,$p.Value,$null) }
$old=[Environment]::CurrentDirectory
try {
[Environment]::CurrentDirectory=$BuildRoot
Set-Location -LiteralPath $BuildRoot
$productCode=[Guid]::NewGuid()
foreach($arch in @(@('Intel;','_i386'),@('x64;','_amd64'))) {
    $ok=$t.GetMethod('CreateWindowsInstallerPackage',$flags).Invoke($keyboard,[object[]]@($bldr,$arch[0],$arch[1],$productCode,$false))
    if(-not $ok){throw ('MSI build failed: '+$Name+$arch[1])}
}
if(-not $t.GetMethod('SetupBootstrapFile',$flags).Invoke($keyboard,[object[]]@($bldr))) {throw 'Setup bootstrap failed'}
} finally { [Environment]::CurrentDirectory=$old; $keyboard.Dispose() }
