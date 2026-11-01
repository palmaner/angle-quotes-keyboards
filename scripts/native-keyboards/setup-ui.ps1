param([Parameter(Mandatory=$true)][string]$PackageRoot,[switch]$Preview,
    [string]$PreviewLanguage,[ValidateSet('Absent','Installed','Active')][string]$PreviewState='Absent',
    [string]$PreviewImage,[switch]$CheckStartup)
$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[Windows.Forms.Application]::EnableVisualStyles()
. (Join-Path $PSScriptRoot 'setup-core.ps1')
. (Join-Path $PSScriptRoot 'setup-msi.ps1')
$script:AqWindowTitle='Angle Quotes'
function Show-AqError($ErrorRecord){
    $details=$script:AqWindowTitle+"`r`n"+(Get-AqErrorText $ErrorRecord)
    $heading=if($t){$t.failure}else{'Angle Quotes: setup could not complete.'}
    $path=''
    try {
        $logs=Join-Path ([Environment]::GetFolderPath('LocalApplicationData')) 'AngleQuotes\logs'
        New-Item -ItemType Directory -Path $logs -Force | Out-Null
        $path=Join-Path $logs ('setup-'+[DateTime]::Now.ToString('yyyyMMdd-HHmmss')+'-'+[Guid]::NewGuid().ToString('N')+'.txt')
        [IO.File]::WriteAllText($path,$details,[Text.UTF8Encoding]::new($true))
    }catch{$path=''} # Diagnostic failure must not hide the original error.
    $summary=$heading+"`r`n`r`n"+$ErrorRecord.Exception.Message+"`r`n"+$ErrorRecord.FullyQualifiedErrorId
    if($ErrorRecord.InvocationInfo.PositionMessage){$summary+="`r`n"+$ErrorRecord.InvocationInfo.PositionMessage}
    if($path){$summary+="`r`n`r`n"+$path}
    [void][Windows.Forms.MessageBox]::Show($summary,$script:AqWindowTitle,'OK','Error')
}
try {
    $config=Get-Content (Join-Path $PSScriptRoot 'setup-config.json') -Raw -Encoding UTF8 | ConvertFrom-Json
    $script:AqWindowTitle='Angle Quotes - v'+$config.version
    $layout=$config.layout
    $code=[Globalization.CultureInfo]::CurrentUICulture.TwoLetterISOLanguageName
    if($Preview -and $PreviewLanguage){$code=$PreviewLanguage}
    if($code -eq 'no'){$code='nb'}
    $t=$config.texts.$code
    if(-not $t){$t=$config.texts.en}
    $script:AqStateRoot=Join-Path ([Environment]::GetFolderPath('LocalApplicationData')) 'AngleQuotes\defaults'
    $mutex=New-Object Threading.Mutex($false,('Local\AngleQuotes-Setup-'+[Security.Principal.WindowsIdentity]::GetCurrent().User.Value))
    try{$locked=$mutex.WaitOne(0)}catch [Threading.AbandonedMutexException]{$locked=$true}
    if(-not $locked){[void][Windows.Forms.MessageBox]::Show($t.alreadyOpen,$script:AqWindowTitle);exit 1}
    function Refresh-AqForm {
        if($Preview){$script:status=[pscustomobject]@{Installed=($PreviewState -ne 'Absent');Active=($PreviewState -eq 'Active');Id=''}}
        else{$script:status=Get-AqStatus $layout}
        $check.Checked=$script:status.Active
        $state.Text=if($script:status.Active){$t.active}elseif($script:status.Installed){$t.installed}else{$t.absent}
        $apply.Text=if($script:status.Installed){$t.apply}else{$t.install}
        $remove.Enabled=$script:status.Installed
        $note.Text=if($script:status.Installed){$t.note}else{$t.firstNote}
    }
    function Select-AqFallback {
        $plan=Get-AqRestorePlan $layout
        if(-not $plan.NeedsChoice){return ''}
        if(-not $plan.Candidates.Count){throw $t.noFallback}
        $dialog=New-Object Windows.Forms.Form
        $dialog.Text=$t.restore;$dialog.ClientSize=New-Object Drawing.Size(550,180)
        $dialog.StartPosition='CenterParent';$dialog.FormBorderStyle='FixedDialog'
        $dialog.MaximizeBox=$false;$dialog.MinimizeBox=$false
        $label=New-Object Windows.Forms.Label
        $label.Text=$t.choose;$label.SetBounds(20,15,510,55)
        $combo=New-Object Windows.Forms.ComboBox
        $combo.SetBounds(20,75,510,30);$combo.DropDownStyle='DropDownList';$combo.DisplayMember='Title'
        foreach($item in $plan.Candidates){[void]$combo.Items.Add($item)}
        $combo.SelectedIndex=0
        $ok=New-Object Windows.Forms.Button
        $ok.Text=$t.apply;$ok.SetBounds(305,125,110,32);$ok.DialogResult='OK'
        $cancel=New-Object Windows.Forms.Button
        $cancel.Text=$t.cancel;$cancel.SetBounds(425,125,105,32);$cancel.DialogResult='Cancel'
        $dialog.Controls.AddRange(@($label,$combo,$ok,$cancel));$dialog.AcceptButton=$ok;$dialog.CancelButton=$cancel
        try {
            if($dialog.ShowDialog($form) -ne 'OK'){throw [OperationCanceledException]::new($t.cancel)}
            return [string]$combo.SelectedItem.Tip
        }finally{$dialog.Dispose()}
    }
    function Assert-AqMsiPlan($Plan) {
        if($Plan.Available){return}
        $logs=Join-Path ([Environment]::GetFolderPath('LocalApplicationData')) 'AngleQuotes\logs'
        New-Item -ItemType Directory -Path $logs -Force | Out-Null
        $diagnostic=Join-Path $logs ('msi-inventory-'+[Guid]::NewGuid().ToString('N')+'.json')
        $Plan | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $diagnostic -Encoding UTF8
        throw ($t.($Plan.Reason)+"`r`n"+$diagnostic)
    }
    function Invoke-AqMsi($Plan) {
        if(-not $Plan){$Plan=Get-AqMsiPlan $layout $PackageRoot}
        Assert-AqMsiPlan $Plan
        $logs=Join-Path ([Environment]::GetFolderPath('LocalApplicationData')) 'AngleQuotes\logs'
        New-Item -ItemType Directory -Path $logs -Force | Out-Null
        $log=Join-Path $logs ('msi-'+$Plan.Operation+'-'+[Guid]::NewGuid().ToString('N')+'.log')
        $Plan | ConvertTo-Json | Set-Content -LiteralPath ($log+'.json') -Encoding UTF8
        $parameters=@{FilePath=(Join-Path $env:SystemRoot 'System32\msiexec.exe');ArgumentList=(Get-AqMsiArguments $Plan $log);PassThru=$true}
        if($Plan.Elevate){$parameters.Verb='RunAs'}
        $process=Start-Process @parameters
        try {
            while(-not $process.WaitForExit(100)){[Windows.Forms.Application]::DoEvents()}
            if($process.ExitCode -eq 1602){throw [OperationCanceledException]::new($t.cancel)}
            if($process.ExitCode -eq 1605){throw ($t.uninstallUnknown+"`r`nWindows Installer: 1605`r`n"+$log)}
            if($process.ExitCode -notin @(0,3010)){throw ('Windows Installer: '+$process.ExitCode+"`r`n"+$log)}
            if($process.ExitCode -eq 0 -and -not (Test-AqMsiCompletion $Plan)){throw ($t.msiIncomplete+"`r`n"+$log)}
            return ($process.ExitCode -eq 3010)
        }finally{$process.Dispose()}
    }
    function Set-AqBusy([bool]$Busy) {
        $script:busy=$Busy
        $apply.Enabled=-not $Busy;$remove.Enabled=(-not $Busy -and $script:status.Installed)
        $check.Enabled=-not $Busy;$close.Enabled=-not $Busy
        $form.UseWaitCursor=$Busy
        if($Busy){$state.Text=$t.working;$form.Refresh()}
    }
    $form=New-Object Windows.Forms.Form
    $form.Text=$script:AqWindowTitle;$form.ClientSize=New-Object Drawing.Size(650,340)
    $form.Font=New-Object Drawing.Font('Segoe UI',10)
    $form.StartPosition='CenterScreen';$form.FormBorderStyle='FixedDialog'
    $form.MaximizeBox=$false;$form.MinimizeBox=$false
    $title=New-Object Windows.Forms.Label
    $title.Text=$layout.title;$title.Font=New-Object Drawing.Font('Segoe UI',13,[Drawing.FontStyle]::Bold)
    $title.SetBounds(24,20,600,55)
    $state=New-Object Windows.Forms.Label
    $state.SetBounds(24,80,600,35)
    $check=New-Object Windows.Forms.CheckBox
    $check.Text=$t.default;$check.SetBounds(24,125,600,50)
    $note=New-Object Windows.Forms.Label
    $note.Text=$t.note;$note.SetBounds(24,185,600,70)
    $apply=New-Object Windows.Forms.Button
    $apply.SetBounds(24,280,185,38)
    $remove=New-Object Windows.Forms.Button
    $remove.Text=$t.remove;$remove.SetBounds(220,280,185,38)
    $close=New-Object Windows.Forms.Button
    $close.Text=$t.close;$close.SetBounds(430,280,195,38);$close.Add_Click({$form.Close()})
    $form.Controls.AddRange(@($title,$state,$check,$note,$apply,$remove,$close))
    $form.Add_FormClosing({param($sender,$eventArgs) if($script:busy){$eventArgs.Cancel=$true}})
    $apply.Add_Click({
        if($Preview){return}
        $wanted=$check.Checked
        try {
            Set-AqBusy $true
            $current=Get-AqStatus $layout
            $previous=Get-AqSnapshot
            $restart=$false
            if(-not $current.Installed){
                # MSKLC may alter the language list. Save the preference before running MSI.
                Save-AqPrevious $layout $previous
                $restart=Invoke-AqMsi
            }
            if($wanted){Enable-AqDefault $layout $previous}
            elseif((Get-AqStatus $layout).Active){Disable-AqDefault $layout (Select-AqFallback)}
            Refresh-AqForm
            $message=$t.saved+"`r`n`r`n"+$t.signOut
            if($restart){$message+="`r`n"+$t.restart}
            [void][Windows.Forms.MessageBox]::Show($form,$message,$script:AqWindowTitle,'OK','Information')
        }catch [OperationCanceledException]{}catch{Show-AqError $_}
        finally{Refresh-AqForm;Set-AqBusy $false}
    })
    $remove.Add_Click({
        if($Preview){return}
        if([Windows.Forms.MessageBox]::Show($form,$t.confirmRemove,$script:AqWindowTitle,'YesNo','Question') -ne 'Yes'){return}
        try {
            Set-AqBusy $true
            $current=Get-AqStatus $layout
            $plan=Get-AqMsiPlan $layout $PackageRoot -Uninstall
            Assert-AqMsiPlan $plan
            if($current.Active){Disable-AqDefault $layout (Select-AqFallback)}
            $restart=Invoke-AqMsi $plan
            Remove-AqUserTip $layout $current.Id
            $path=Get-AqStatePath $layout
            if(Test-Path -LiteralPath $path){Remove-Item -LiteralPath $path}
            Refresh-AqForm
            $message=$t.saved+"`r`n`r`n"+$t.signOut
            if($restart){$message+="`r`n"+$t.restart}
            [void][Windows.Forms.MessageBox]::Show($form,$message,$script:AqWindowTitle,'OK','Information')
        }catch [OperationCanceledException]{}catch{Show-AqError $_}
        finally{Refresh-AqForm;Set-AqBusy $false}
    })
    Refresh-AqForm
    if($CheckStartup){$script:status | ConvertTo-Json; $form.Dispose(); return}
    if($Preview -and $PreviewImage){
        # Render only this preview form; all preference and MSI actions are disabled.
        $form.Show();$form.Refresh();[Windows.Forms.Application]::DoEvents()
        $bitmap=New-Object Drawing.Bitmap($form.Width,$form.Height)
        try{$form.DrawToBitmap($bitmap,[Drawing.Rectangle]::new(0,0,$form.Width,$form.Height));$bitmap.Save($PreviewImage,[Drawing.Imaging.ImageFormat]::Png)}
        finally{$bitmap.Dispose()}
    }else{[void]$form.ShowDialog()}
    $form.Dispose()
}catch{
    if($CheckStartup){throw}
    Show-AqError $_
    exit 1
}finally{
    if($locked){$mutex.ReleaseMutex()}
    if($mutex){$mutex.Dispose()}
}
