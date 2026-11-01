$ErrorActionPreference='Stop'
. (Join-Path $PSScriptRoot 'setup-core.ps1')
$repo=[IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
$script:AqStateRoot=Join-Path $repo ('work\native-keyboards\setup-tests-'+[Guid]::NewGuid().ToString('N'))
$script:checks=0
function Assert($Condition,[string]$Message){if(-not $Condition){throw $Message};$script:checks++}
function Assert-Throws([scriptblock]$Action,[string]$Message){
    $threw=$false;try{& $Action}catch{$threw=$true};Assert $threw $Message
}
# All Windows settings and registry operations below are replaced with in-memory doubles.
function Get-AqRegisteredLayouts {return $script:registered}
function Get-WinDefaultInputMethodOverride {
    if($script:overrideReadError){throw $script:overrideReadError}
    if($script:override){[pscustomobject]@{InputMethodTip=$script:override}}
}
function Get-AqStoredOverride {$script:fallbackReads++;return $script:storedOverride}
function Set-WinDefaultInputMethodOverride([string]$InputTip){
    if(-not $script:rejectWrite){$script:override=$InputTip};$script:writes++
}
function Get-WinUserLanguageList {
    if($script:languageReadError){throw [Exception]::new('Language-list read failed')}
    return ,$script:languages
}
function Set-WinUserLanguageList($LanguageList,[switch]$Force){$script:languages=$LanguageList;$script:listWrites++}
function New-WinUserLanguageList([string]$Language){
    $list=New-Object 'Collections.Generic.List[object]'
    $tips=New-Object 'Collections.Generic.List[string]'
    if($Language -eq 'en-US'){$tips.Add('0409:00000409')}
    $list.Add([pscustomobject]@{LanguageTag=$Language;Autonym=$Language;InputMethodTips=$tips;Handwriting=$true})
    return ,$list
}
function Reset-Fixture {
    $script:override='0409:00000409';$script:writes=0;$script:listWrites=0;$script:rejectWrite=$false
    $script:overrideReadError=$null;$script:languageReadError=$false;$script:storedOverride='';$script:fallbackReads=0
    $script:registered=@(
        [pscustomobject]@{Id='00000409';File='kbdus.dll';Title='US'},
        [pscustomobject]@{Id='a123040a';File='aqes.dll';Title='Spanish - Angle Quotes'},
        [pscustomobject]@{Id='a4560410';File='aqit.dll';Title='Italian - Angle Quotes'}
    )
    $script:languages=New-WinUserLanguageList 'en-US'
}
$layout=[pscustomobject]@{name='aqes';locale='es-ES'}
$other=[pscustomobject]@{name='aqit';locale='it-IT'}
try {
    Reset-Fixture
    Assert ((Get-AqStatus $layout).Installed -and -not (Get-AqStatus $layout).Active) 'Initial status'
    Enable-AqDefault $layout
    Assert ($script:override -eq '0c0a:a123040a') 'Use real registered KLID, not Windows base'
    Assert ($script:languages.Count -eq 2 -and $script:languages[0].LanguageTag -eq 'en-US') 'Preserve language order'
    Assert $script:languages[0].Handwriting 'Preserve unrelated language properties'
    Assert ($script:languages[0].InputMethodTips[0] -eq '0409:00000409') 'Preserve original keyboard'
    $backup=Get-Content (Get-AqStatePath $layout) -Raw
    Enable-AqDefault $layout
    Assert ((Get-Content (Get-AqStatePath $layout) -Raw) -ceq $backup) 'Repeated activation preserves backup'
    Assert ($script:listWrites -eq 1) 'Repeated activation does not rewrite language list'
    Disable-AqDefault $layout
    Assert ($script:override -eq '0409:00000409') 'Restore previous explicit default'
    Assert ($script:languages[1].InputMethodTips.Contains('0c0a:a123040a')) 'Deactivation leaves keyboard selectable'
    $writes=$script:writes;Disable-AqDefault $layout
    Assert ($script:writes -eq $writes) 'Do not overwrite an external change of default'
    Enable-AqDefault $layout
    Enable-AqDefault $other
    Disable-AqDefault $other
    Assert ((Get-AqStatus $layout).Active) 'Two layouts restore defaults in sequence'
    Disable-AqDefault $layout
    Assert ($script:override -eq '0409:00000409') 'Sequence returns to original'
    $script:override='';Enable-AqDefault $layout;Disable-AqDefault $layout
    Assert ($script:override -eq '') 'Restore automatic language-list preference'
    $script:override='';Enable-AqDefault $layout
    $original=$script:languages[0];$script:languages.RemoveAt(0);$script:languages.Add($original)
    Disable-AqDefault $layout
    Assert ($script:override -eq '0409:00000409') 'Preserve old effective default after language-order change'
    Enable-AqDefault $layout
    $script:registered=@($script:registered | Where-Object Id -ne '00000409')
    Assert (Get-AqRestorePlan $layout).NeedsChoice 'Missing previous keyboard requires choice'
    Assert-Throws {Disable-AqDefault $layout} 'Never silently choose a fallback'
    Assert-Throws {Disable-AqDefault $layout '0c0a:a123040a'} 'Reject self as fallback'
    $script:languages.Add((New-WinUserLanguageList 'it-IT')[0])
    $script:languages[$script:languages.Count-1].InputMethodTips.Clear()
    $script:languages[$script:languages.Count-1].InputMethodTips.Add('0410:a4560410')
    Disable-AqDefault $layout '0410:a4560410'
    Assert ((Get-AqStatus $other).Active) 'Restore chosen available fallback'
    $script:override='0c0a:a123040a'
    Remove-Item -LiteralPath (Get-AqStatePath $layout)
    Assert (Get-AqRestorePlan $layout).NeedsChoice 'External activation without backup requires choice'
    Disable-AqDefault $layout '0410:a4560410'
    Remove-AqUserTip $layout 'a123040a'
    Assert (-not $script:languages[0].InputMethodTips.Contains('0c0a:a123040a')) 'Remove only this layout tip'
    Assert ((Get-AqSnapshot).Effective -eq '0410:a4560410') 'Uninstall cleanup preserves replacement default'
    Reset-Fixture
    $tips=$script:languages[0].InputMethodTips
    $tips.Insert(0,'0409:a123040a');$script:override=''
    Enable-AqDefault $layout
    Assert ($script:override -eq '0409:a123040a') 'Make an implicit default explicit without saving itself as previous'
    Reset-Fixture
    $script:registered=@($script:registered | Where-Object File -ne 'aqes.dll')
    Assert-Throws {Enable-AqDefault $layout} 'Refuse activation before registration'
    Assert ($script:writes -eq 0 -and $script:listWrites -eq 0) 'Missing layout changes no preferences'
    Reset-Fixture
    $script:rejectWrite=$true
    Assert-Throws {Enable-AqDefault $layout} 'Detect Windows refusing preference write'
    Assert (Test-Path -LiteralPath (Get-AqStatePath $layout)) 'Keep recovery state on failure'
    Reset-Fixture
    $script:registered=@();$script:overrideReadError=[Exception]::new('Fresh session')
    $script:languageReadError=$true
    Assert (-not (Get-AqStatus $layout).Installed) 'Uninstalled status does not consult user preferences'
    Assert ($script:fallbackReads -eq 0) 'No preference fallback during uninstalled startup'
    Reset-Fixture
    $script:overrideReadError=[Exception]::new('Generic International module error')
    $snapshot=Get-AqSnapshot
    Assert ($snapshot.Override -eq '' -and $snapshot.Effective -eq '0409:00000409') 'Missing explicit override uses language list after generic cmdlet error'
    $script:storedOverride='0409:00000409';$script:languageReadError=$true
    Assert ((Get-AqSnapshot).Effective -eq '0409:00000409') 'Stored explicit override avoids unnecessary language-list read'
    $script:storedOverride='invalid'
    Assert-Throws {Get-AqOverride} 'Reject malformed stored override'
    $script:overrideReadError=[UnauthorizedAccessException]::new('Access denied');$script:fallbackReads=0
    Assert-Throws {Get-AqOverride} 'Do not swallow permission failures'
    Assert ($script:fallbackReads -eq 0) 'Permission failure does not use generic-exception fallback'
    try{Get-AqOverride}catch{
        $diagnostic=Get-AqErrorText $_
        Assert ($diagnostic.Contains('Access denied') -and $diagnostic.Contains('test-setup.ps1')) 'Diagnostics retain exception and script location'
    }
    Reset-Fixture
    $script:registered+=@([pscustomobject]@{Id='a999040a';File='aqes.dll';Title='Duplicate'})
    Assert-Throws {Get-AqStatus $layout} 'Reject ambiguous registration'
    Write-Output ('PASSED: '+$script:checks+' setup preference checks; Windows settings untouched.')
}finally{
    if(Test-Path -LiteralPath $script:AqStateRoot){
        Get-ChildItem -LiteralPath $script:AqStateRoot -File | Remove-Item -Force
        Remove-Item -LiteralPath $script:AqStateRoot
    }
}
