param([ValidateSet('auto','wow64')][string]$Target='auto')
$ErrorActionPreference='Stop'
$repo=[IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
Add-Type -Path (Join-Path $PSScriptRoot 'InspectLayout.cs')
$layouts=Get-Content (Join-Path $PSScriptRoot 'layouts.json') -Raw | ConvertFrom-Json
$results=@()
$architecture=if([IntPtr]::Size -eq 8){'amd64'}else{'i386'}
if($Target -eq 'wow64') {if([IntPtr]::Size -ne 4){throw 'WOW64 inspection requires a 32-bit process'};$architecture='wow64'}
$failures=New-Object 'Collections.Generic.List[string]'
foreach($layout in $layouts) {
    $reg=Get-ItemProperty ('HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\'+$layout.base)
    $baseline=[LayoutTables]::new((Join-Path $env:SystemRoot ('System32\'+$reg.'Layout File')),$true)
    $custom=[LayoutTables]::new((Join-Path $repo ('outputs\native-keyboards\'+$layout.slug+'\'+$architecture+'\'+$layout.name+'.dll')),($architecture -eq 'wow64'))
    $count=0
    try {
        foreach($scan in @(2..53)+@(0x39,0x56)) {
            $baseVk=$baseline.VirtualKey($scan);$customVk=$custom.VirtualKey($scan)
            if($baseVk -ne $customVk) { $failures.Add($layout.slug+': changed VK at scan '+$scan);continue }
            foreach($mod in @(0,1,2,3,6,7)) {
                foreach($caps in @($false,$true)) {
                    $old=$baseline.Symbol($baseVk,$mod,$caps)
                    $new=$custom.Symbol($customVk,$mod,$caps)
                    $prop=$layout.keys.PSObject.Properties[$scan.ToString('x2')]
                    if($mod -eq 6 -and $null -ne $prop) {
                        if($new -ne $prop.Value){$failures.Add($layout.slug+': wrong new symbol '+$scan+' caps='+$caps+' '+$new)}
                    } elseif($old -ne $new) {
                        $failures.Add($layout.slug+': changed scan='+$scan+' mod='+$mod+' caps='+$caps+' '+$old+' => '+$new)
                    }
                    $count++
                }
            }
        }
        $oldDead=$baseline.DeadKeys();$newDead=$custom.DeadKeys()
        foreach($key in $oldDead.Keys) {
            if(-not $newDead.ContainsKey($key) -or $newDead[$key] -ne $oldDead[$key]) {$failures.Add($layout.slug+': changed dead key '+$key)}
        }
        $results+= [pscustomobject]@{layout=$layout.slug;characterChecks=$count;deadKeyChecks=$oldDead.Count}
    } finally {$baseline.Dispose();$custom.Dispose()}
}
$report=[ordered]@{passed=($failures.Count -eq 0);architecture=$architecture;layouts=$results;failures=@($failures);installed=$false;interactiveTyping=$false}
$report | ConvertTo-Json -Depth 6 | Set-Content (Join-Path $repo ('work\native-keyboards\validation-'+$architecture+'.json')) -Encoding UTF8
if($failures.Count){$failures | Select-Object -First 65;throw ('FAILED: '+$failures.Count)}
Write-Output ('PASSED: '+$results.Count+' native layouts; '+(($results | Measure-Object characterChecks -Sum).Sum)+' character checks')
