$ErrorActionPreference='Stop'
$repo=[IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
if(-not ('LayoutTables' -as [type])){Add-Type -Path (Join-Path $PSScriptRoot 'InspectLayout.cs')}
$catalog=Get-Content (Join-Path $PSScriptRoot 'layouts.json') -Raw -Encoding UTF8 | ConvertFrom-Json
$report=foreach($layout in $catalog){
    $reg=Get-ItemProperty ('HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\'+$layout.base)
    $base=[LayoutTables]::new((Join-Path $env:SystemRoot ('System32\'+$reg.'Layout File')),$true)
    $new=[LayoutTables]::new((Join-Path $repo ('outputs\native-keyboards\'+$layout.slug+'\amd64\'+$layout.name+'.dll')))
    try {
        $changes=foreach($key in $layout.keys.PSObject.Properties){
            $scan=[Convert]::ToInt32($key.Name,16)
            $old=$base.Symbol($base.VirtualKey($scan),6,$false)
            $actual=$new.Symbol($new.VirtualKey($scan),6,$false)
            if($actual -ne $key.Value){throw ('Incorrect character in '+$layout.slug)}
            $alternatives=if($old -and $old -ne $actual){
                foreach($s in 2..86){foreach($mod in @(0,1,6,7)){
                    if($new.Symbol($new.VirtualKey($s),$mod,$false) -eq $old){'scan'+$s.ToString('x2')+'/mod'+$mod}
                }}
            }
            [pscustomobject]@{key=($scan-1);old=$old;new=$actual;alternatives=@($alternatives)}
        }
        [pscustomobject]@{layout=$layout.slug;changes=@($changes)}
    }finally{$base.Dispose();$new.Dispose()}
}
$report | ConvertTo-Json -Depth 7 | Set-Content (Join-Path $repo 'work\native-keyboards\character-changes.json') -Encoding UTF8
