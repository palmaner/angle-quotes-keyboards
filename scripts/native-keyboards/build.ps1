param([string[]]$Only)
$ErrorActionPreference='Stop'
$repo=[IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
$work=Join-Path $repo 'work\native-keyboards'
$out=Join-Path $repo 'outputs\native-keyboards'
New-Item -ItemType Directory -Path $work,$out -Force | Out-Null
$shell=Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'
$tool='C:\Program Files (x86)\Microsoft Keyboard Layout Creator 1.4\bin\i386\kbdutool.exe'
$layouts=Get-Content (Join-Path $PSScriptRoot 'layouts.json') -Raw | ConvertFrom-Json
if($Only){$layouts=@($layouts | Where-Object {$_.slug -in $Only})}
Add-Type -Path (Join-Path $PSScriptRoot 'InspectLayout.cs')
foreach($layout in $layouts) {
    Write-Host ('BUILD '+$layout.slug)
    $baseFile=Join-Path $work ($layout.name+'-base.klc')
    $savedBase=Join-Path $repo ('sources\base\'+$layout.name+'-base.klc')
    if(-not (Test-Path -LiteralPath $baseFile) -and (Test-Path -LiteralPath $savedBase)){
        Copy-Item -LiteralPath $savedBase -Destination $baseFile
    }
    if(-not (Test-Path -LiteralPath $baseFile)) {
        & $shell -NoProfile -STA -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot 'export.ps1') -Id $layout.base -OutFile $baseFile
        if($LASTEXITCODE -ne 0){throw 'Export failed'}
    }
    $lines=[IO.File]::ReadAllLines($baseFile)
    $states=New-Object 'Collections.Generic.List[int]'
    $inStates=$false
    foreach($line in $lines) {
        if($line -match '^SHIFTSTATE'){$inStates=$true;continue}
        if($line -match '^LAYOUT'){$inStates=$false}
        if($inStates -and $line -match '^(\d+)\s'){$states.Add([int]$Matches[1])}
    }
    $oldStates=@($states)
    if(-not $states.Contains(6)){$states.Add(6)}
    if(-not $states.Contains(3)){$states.Add(3)}
    $states.Sort()
    $altCol=3+$states.IndexOf(6)
    $baseReg=Get-ItemProperty ('HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\'+$layout.base)
    $baseline=[LayoutTables]::new((Join-Path $env:SystemRoot ('System32\'+$baseReg.'Layout File')))
    $inLayout=$false
    $inDescriptions=$false
    $changed=0
    $newLines=foreach($line in $lines) {
        if($line -match '^DESCRIPTIONS\s*$') {
            $inDescriptions=$true
            'DESCRIPTIONS';''
            '0409'+"`t"+$layout.title
            continue
        }
        if($inDescriptions){
            if($line -match '^LANGUAGENAMES\s*$'){$inDescriptions=$false}else{continue}
        }
        if($line -match '^KBD\s') { 'KBD'+"`t"+$layout.name+"`t"+'"'+$layout.title+'"';continue }
        if($line -match '^LOCALENAME\s') { 'LOCALENAME'+"`t"+'"'+$layout.locale+'"';continue }
        if($line -match '^LOCALEID\s') { 'LOCALEID'+"`t"+'"'+([Globalization.CultureInfo]$layout.locale).LCID.ToString('x8')+'"';continue }
        if($line -match '^SHIFTSTATE') {
            'SHIFTSTATE';''
            foreach($state in $states){[string]$state+"`t// Modifier state"}
            ''
            $inStates=$true
            continue
        }
        if($line -match '^LAYOUT') {
            $inStates=$false;$inLayout=$true
        } elseif($inLayout -and $line -match '^[A-Z_]+(?:\s|$)') { $inLayout=$false }
        if($inStates){continue}
        if($inLayout -and $line -match '^(?:[0-9a-fA-F]{2}|-1)\s') {
            $oldTokens=($line -split '//',2)[0].Trim() -split '\s+'
            $tokens=@($oldTokens[0..2])
            foreach($state in $states) {
                $idx=[Array]::IndexOf($oldStates,$state)
                $value=if($idx -ge 0){$oldTokens[3+$idx]}else{'-1'}
                if($oldTokens[0] -ne '-1' -and $state -in @(2,3)) {
                    $scan=[Convert]::ToInt32($oldTokens[0],16)
                    $symbol=$baseline.Symbol($baseline.VirtualKey($scan),$state,$false)
                    if($symbol -match '^[0-9a-f]{4}$'){$value=$symbol}
                }
                $tokens+=$value
            }
            $sc=$tokens[0].ToLowerInvariant()
            $prop=$layout.keys.PSObject.Properties[$sc]
            if($null -ne $prop) {$tokens[$altCol]=$prop.Value;$changed++}
            $tokens -join "`t"
        } else { $line }
    }
    $baseline.Dispose()
    if($changed -ne $layout.keys.PSObject.Properties.Count){
        # PowerShell enumerates Count differently for PSCustomObject properties.
        if($changed -ne @($layout.keys.PSObject.Properties).Count){throw 'Missing target keys'}
    }
    $build=Join-Path $work ('build-'+$layout.name)
    $package=Join-Path $build $layout.name
    New-Item -ItemType Directory -Path $package -Force | Out-Null
    $source=Join-Path $build ($layout.name+'.klc')
    [IO.File]::WriteAllLines($source,$newLines,[Text.Encoding]::Unicode)
    foreach($arch in @(@('i386','-x'),@('amd64','-m'),@('wow64','-o'),@('ia64','-i'))) {
        $dir=Join-Path $package $arch[0]
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Push-Location -LiteralPath $dir
        try {
            & $tool -u $arch[1] $source | Out-File (Join-Path $build ($arch[0]+'.log'))
            if($LASTEXITCODE -ne 0 -or -not (Test-Path ($layout.name+'.dll'))){throw ('Compiler failed: '+$layout.name+' '+$arch[0])}
        } finally { Pop-Location }
    }
    & $shell -NoProfile -STA -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot 'package-msi.ps1') -BuildRoot $build -Name $layout.name -Title $layout.title -Locale $layout.locale
    if($LASTEXITCODE -ne 0){throw 'MSI packaging failed'}
    $dest=Join-Path $out $layout.slug
    New-Item -ItemType Directory -Path $dest -Force | Out-Null
    Copy-Item -LiteralPath (Join-Path $package 'setup.exe') -Destination $dest -Force
    foreach($suffix in @('_i386.msi','_amd64.msi')) {Copy-Item -LiteralPath (Join-Path $package ($layout.name+$suffix)) -Destination $dest -Force}
    foreach($arch in @('i386','amd64','wow64')) {
        New-Item -ItemType Directory -Path (Join-Path $dest $arch) -Force | Out-Null
        Copy-Item -LiteralPath (Join-Path $package ($arch+'\'+$layout.name+'.dll')) -Destination (Join-Path $dest $arch) -Force
    }
    Copy-Item -LiteralPath $source -Destination (Join-Path $work ($layout.name+'.klc')) -Force
}
& (Join-Path $PSScriptRoot 'build-setup.ps1') -Only $Only
