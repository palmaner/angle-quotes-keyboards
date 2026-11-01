# This file is also dot-sourced by the isolated tests. Loading it changes no settings.
function Get-AqRegisteredLayouts {
    @(Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layouts' | ForEach-Object {
        $p=Get-ItemProperty -LiteralPath $_.PSPath
        [pscustomobject]@{Id=$_.PSChildName;File=$p.'Layout File';Title=$p.'Layout Text'}
    })
}
function Get-AqLayoutId($Layout) {
    $matches=@(Get-AqRegisteredLayouts | Where-Object File -eq ($Layout.name+'.dll'))
    if($matches.Count -gt 1){throw 'Ambiguous keyboard registration.'}
    if($matches.Count -eq 1){return $matches[0].Id}
    return ''
}
function Get-AqStoredOverride {
    # Read-only fallback: never create or edit the Windows preference registry key.
    $key=[Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Control Panel\International\User Profile',$false)
    if(-not $key){return ''}
    try{return [string]$key.GetValue('InputMethodOverride','')}
    finally{$key.Dispose()}
}
function Get-AqOverride {
    try{$value=Get-WinDefaultInputMethodOverride -ErrorAction Stop}
    catch {
        # Some International-module versions throw a plain System.Exception here.
        # Do not reinterpret access-denied or other failures as an empty preference.
        if($_.Exception.GetBaseException().GetType() -ne [System.Exception]){throw}
        $stored=Get-AqStoredOverride
        if($stored -and $stored -notmatch '^[0-9a-f]{4}:(?:[0-9a-f]{8}|\{[0-9a-f-]{36}\}\{[0-9a-f-]{36}\})$'){
            throw [IO.InvalidDataException]::new('Invalid stored input-method override.')
        }
        return $stored
    }
    if($value){return [string]$value.InputMethodTip}
    return ''
}
function Get-AqSnapshot {
    $override=Get-AqOverride
    $effective=$override
    if(-not $override){
        $tips=@(Get-WinUserLanguageList -ErrorAction Stop | ForEach-Object {$_.InputMethodTips} | Where-Object {$_})
        $effective=if($tips.Count){$tips[0]}else{''}
    }
    [pscustomobject]@{Override=$override;Effective=$effective}
}
function Test-AqTip([string]$Tip,[string]$Id) {
    return ($Id -and $Tip -match (':'+[regex]::Escape($Id)+'$'))
}
function Get-AqStatus($Layout) {
    $id=Get-AqLayoutId $Layout
    if(-not $id){return [pscustomobject]@{Id='';Installed=$false;Active=$false}}
    $snapshot=Get-AqSnapshot
    [pscustomobject]@{Id=$id;Installed=[bool]$id;Active=[bool](Test-AqTip $snapshot.Effective $id)}
}
function Get-AqErrorText($ErrorRecord) {
    @(
        $ErrorRecord.Exception.ToString()
        [string]$ErrorRecord.FullyQualifiedErrorId
        [string]$ErrorRecord.InvocationInfo.PositionMessage
        [string]$ErrorRecord.ScriptStackTrace
    ) -join "`r`n"
}
function Get-AqStatePath($Layout) {
    Join-Path $script:AqStateRoot ($Layout.name+'.json')
}
function Save-AqPrevious($Layout,$Snapshot) {
    # Never replace the original preference with this keyboard on repeated activation.
    $id=Get-AqLayoutId $Layout
    if(Test-AqTip $Snapshot.Effective $id){return}
    New-Item -ItemType Directory -Path $script:AqStateRoot -Force | Out-Null
    $path=Get-AqStatePath $Layout
    $temp=$path+'.'+[Guid]::NewGuid().ToString('N')+'.tmp'
    try {
        $Snapshot | ConvertTo-Json | Set-Content -LiteralPath $temp -Encoding UTF8
        Move-Item -LiteralPath $temp -Destination $path -Force
    }finally{if(Test-Path -LiteralPath $temp){Remove-Item -LiteralPath $temp}}
}
function Get-AqCandidates([string]$ExcludedId) {
    $registered=@(Get-AqRegisteredLayouts)
    foreach($language in Get-WinUserLanguageList){
        foreach($tip in $language.InputMethodTips){
            if(Test-AqTip $tip $ExcludedId){continue}
            if($tip -match '^[0-9a-f]{4}:([0-9a-f]{8})$'){
                $entry=@($registered | Where-Object Id -eq $Matches[1])
                if(-not $entry.Count){continue}
                $title=$entry[0].Title
            }else{$title=$tip} # Preserve registered IMEs as alternatives, too.
            [pscustomobject]@{Tip=[string]$tip;Title=($language.Autonym+' — '+$title)}
        }
    }
}
function Get-AqRestorePlan($Layout) {
    $id=Get-AqLayoutId $Layout
    $candidates=@(Get-AqCandidates $id)
    $path=Get-AqStatePath $Layout
    if(Test-Path -LiteralPath $path){
        $previous=Get-Content -LiteralPath $path -Raw -Encoding UTF8 | ConvertFrom-Json
        $tip=if($previous.Override){[string]$previous.Override}else{[string]$previous.Effective}
        if($tip -in @($candidates | ForEach-Object {$_.Tip})){
            return [pscustomobject]@{Previous=$previous;Candidates=$candidates;NeedsChoice=$false}
        }
    }
    [pscustomobject]@{Previous=$null;Candidates=$candidates;NeedsChoice=$true}
}
function Set-AqVerifiedOverride([string]$Tip) {
    if($Tip){Set-WinDefaultInputMethodOverride -InputTip $Tip -ErrorAction Stop}
    else{Set-WinDefaultInputMethodOverride -ErrorAction Stop}
    if((Get-AqOverride) -ne $Tip){throw 'Windows did not save the default input method.'}
}
function Enable-AqDefault($Layout,$Previous) {
    $status=Get-AqStatus $Layout
    if(-not $status.Installed){throw 'Keyboard is not registered. Sign out and try again.'}
    if($status.Active -and (Test-AqTip (Get-AqOverride) $status.Id)){return}
    if(-not $Previous){$Previous=Get-AqSnapshot}
    Save-AqPrevious $Layout $Previous
    $list=Get-WinUserLanguageList
    $existing=@($list | ForEach-Object {$_.InputMethodTips} | Where-Object {Test-AqTip $_ $status.Id})
    if($existing.Count){$tip=[string]$existing[0]}
    else {
        $language=@($list | Where-Object LanguageTag -eq $Layout.locale)
        if(-not $language.Count){
            $new=New-WinUserLanguageList -Language $Layout.locale
            $list.Add($new[0]);$language=@($list[$list.Count-1])
        }
        $tip=([Globalization.CultureInfo]$Layout.locale).LCID.ToString('x4')+':'+$status.Id
        $language[0].InputMethodTips.Add($tip)
        Set-WinUserLanguageList -LanguageList $list -Force -ErrorAction Stop
    }
    Set-AqVerifiedOverride $tip
    if(-not (Get-AqStatus $Layout).Active){throw 'Windows did not retain the selected keyboard.'}
}
function Disable-AqDefault($Layout,[string]$FallbackTip) {
    if(-not (Get-AqStatus $Layout).Active){return}
    $plan=Get-AqRestorePlan $Layout
    if($plan.NeedsChoice){
        if(-not $FallbackTip -or $FallbackTip -notin @($plan.Candidates | ForEach-Object {$_.Tip})){
            throw 'Choose an available replacement keyboard first.'
        }
        Set-AqVerifiedOverride $FallbackTip
    }elseif($plan.Previous.Override){Set-AqVerifiedOverride $plan.Previous.Override}
    else {
        # Return to Windows language-list selection when it still selects the old keyboard.
        Set-AqVerifiedOverride ''
        if((Get-AqSnapshot).Effective -ne $plan.Previous.Effective){
            Set-AqVerifiedOverride $plan.Previous.Effective
        }
    }
    if((Get-AqStatus $Layout).Active){throw 'The keyboard is still the default.'}
}
function Remove-AqUserTip($Layout,[string]$Id) {
    $list=Get-WinUserLanguageList
    $changed=$false
    foreach($language in $list){
        $remove=@($language.InputMethodTips | Where-Object {Test-AqTip $_ $Id})
        foreach($tip in $remove){[void]$language.InputMethodTips.Remove($tip);$changed=$true}
    }
    if($changed){Set-WinUserLanguageList -LanguageList $list -Force -ErrorAction Stop}
}
