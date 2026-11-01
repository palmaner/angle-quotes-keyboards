$ErrorActionPreference='Stop'
. (Join-Path $PSScriptRoot 'setup-msi.ps1')
$repo=[IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
$fixture=Join-Path $repo ('work\native-keyboards\msi-tests-'+[Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $fixture -Force | Out-Null
$script:checks=0
function Assert($Condition,[string]$Message){if(-not $Condition){throw $Message};$script:checks++}
function Assert-Throws([scriptblock]$Action,[string]$Message){$threw=$false;try{& $Action}catch{$threw=$true};Assert $threw $Message}
# In-memory inventory and package metadata only. Never execute msiexec or alter Windows.
function Get-AqMsiUserSid {'S-1-5-21-current'}
function Get-AqMsiProducts {return $script:products}
function Get-AqMsiPackage([string]$Path){return $script:packages[$Path]}
$layout=[pscustomobject]@{name='aqes';title='Spanish (Spain) - Angle Quotes'}
$newCode='{11111111-1111-1111-1111-111111111111}'
$oldCode='{22222222-2222-2222-2222-222222222222}'
$cache=Join-Path $fixture 'cached-old.msi'
function Reset-Fixture {
    $script:packages=@{}
    foreach($name in @('aqes_i386.msi','aqes_amd64.msi')){
        $p=Join-Path $fixture $name
        [IO.File]::WriteAllText($p,'Fixture, not a real MSI')
        $script:packages[$p]=[pscustomobject]@{ProductCode=$newCode;Name=$layout.title;LayoutFile='aqes.dll'}
    }
    [IO.File]::WriteAllText($cache,'Fixture, not a real MSI')
    $script:packages[$cache]=[pscustomobject]@{ProductCode=$oldCode;Name=$layout.title;LayoutFile='aqes.dll'}
    $script:products=@([pscustomobject]@{ProductCode=$oldCode;Name=$layout.title;Context=4;UserSid='';LocalPackage=$cache})
}
try {
    Reset-Fixture
    $plan=Get-AqMsiPlan $layout $fixture -Uninstall
    Assert ($plan.Available -and $plan.Target -eq $oldCode) 'Uninstall actual registered ProductCode, not code from downloaded MSI'
    Assert ($plan.PackageCode -eq $newCode -and $plan.Target -ne $plan.PackageCode) 'Keep downloaded and installed identities distinct'
    Assert ($plan.Elevate -and $plan.Context -eq 4) 'Machine uninstall requests elevation'
    $args=Get-AqMsiArguments $plan (Join-Path $fixture 'log with spaces.log')
    Assert ($args.StartsWith('/x '+$oldCode)) 'Use installed GUID as removal target'
    Assert ($args.Contains('ALLUSERS=1')) 'Retain machine installation context'
    Assert ($args.Contains('/L*V "') -and $args.EndsWith('log with spaces.log"')) 'Always request a quoted Windows Installer diagnostic log'
    $script:products[0].Context=2;$script:products[0].UserSid=Get-AqMsiUserSid
    $plan=Get-AqMsiPlan $layout $fixture -Uninstall
    Assert ($plan.Available -and -not $plan.Elevate -and $plan.Context -eq 2) 'Per-user removal stays in initiating user context'
    Assert (-not (Get-AqMsiArguments $plan 'test.log').Contains('ALLUSERS=1')) 'Do not turn existing per-user uninstall into machine uninstall'
    $script:products[0].Context=1
    Assert (-not (Get-AqMsiPlan $layout $fixture -Uninstall).Elevate) 'Managed per-user context is not replaced by another administrator'
    $script:products[0].UserSid='S-1-5-21-other'
    Assert (-not (Get-AqMsiPlan $layout $fixture -Uninstall).Available) 'Never select a different user installation'
    Reset-Fixture
    $script:products=@()
    $plan=Get-AqMsiPlan $layout $fixture -Uninstall
    Assert (-not $plan.Available -and $plan.Reason -eq 'uninstallUnknown') 'Registered keyboard alone is not proof of a removable MSI'
    Reset-Fixture
    $script:products+=@([pscustomobject]@{ProductCode=$oldCode;Name=$layout.title;Context=2;UserSid=(Get-AqMsiUserSid);LocalPackage=$cache})
    $plan=Get-AqMsiPlan $layout $fixture -Uninstall
    Assert (-not $plan.Available -and $plan.Reason -eq 'uninstallAmbiguous') 'Multiple matching contexts require investigation'
    Reset-Fixture
    $script:packages[$cache].LayoutFile='different.dll'
    Assert (-not (Get-AqMsiPlan $layout $fixture -Uninstall).Available) 'Do not remove a product using another DLL'
    Reset-Fixture
    $script:packages[$cache].ProductCode=$newCode
    Assert (-not (Get-AqMsiPlan $layout $fixture -Uninstall).Available) 'Cached MSI and registration must identify same product'
    Reset-Fixture
    $script:products[0].Name='Unrelated product'
    Assert (-not (Get-AqMsiPlan $layout $fixture -Uninstall).Available) 'Reject unrelated product names'
    Reset-Fixture
    Remove-Item -LiteralPath $cache
    Assert (-not (Get-AqMsiPlan $layout $fixture -Uninstall).Available) 'Do not guess an identity when cache is unavailable'
    Reset-Fixture
    $script:products[0].ProductCode='not-a-guid';$script:packages[$cache].ProductCode='not-a-guid'
    Assert (-not (Get-AqMsiPlan $layout $fixture -Uninstall).Available) 'Reject invalid product identifiers'
    Reset-Fixture
    $plan=Get-AqMsiPlan $layout $fixture
    Assert ($plan.Operation -eq 'install' -and $plan.Context -eq 4 -and $plan.Elevate) 'New system keyboard installs use machine registration'
    Assert ((Get-AqMsiArguments $plan 'test.log').Contains('ALLUSERS=1')) 'Explicit machine registration on fresh install'
    Assert ((Get-AqMsiArguments $plan 'test.log').StartsWith('/i "')) 'Keep complete package path for installation'
    Assert (-not (Test-AqMsiCompletion $plan)) 'Do not claim installed product exists based on msiexec exit alone'
    $script:products[0].ProductCode=$newCode
    Assert (Test-AqMsiCompletion $plan) 'Confirm fresh machine installation by registered code and context'
    Reset-Fixture
    $plan=Get-AqMsiPlan $layout $fixture -Uninstall
    Assert (-not (Test-AqMsiCompletion $plan)) 'Retained registered product is not successful removal'
    $script:products=@()
    Assert (Test-AqMsiCompletion $plan) 'Confirm removed product no longer exists in selected context'
    $plan.Target='invalid';Assert-Throws {Get-AqMsiArguments $plan 'test.log'} 'Refuse invalid command target'
    Reset-Fixture
    $suffix=if([Environment]::Is64BitOperatingSystem){'aqes_amd64.msi'}else{'aqes_i386.msi'}
    $script:packages[(Join-Path $fixture $suffix)].LayoutFile='other.dll'
    Assert-Throws {Get-AqMsiPlan $layout $fixture} 'Reject substituted source package'
    Write-Output ('PASSED: '+$script:checks+' isolated MSI identity/context checks; no installation or removal performed.')
}finally{
    Get-ChildItem -LiteralPath $fixture -File | Remove-Item -Force
    Remove-Item -LiteralPath $fixture
}
