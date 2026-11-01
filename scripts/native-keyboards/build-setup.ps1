param([string[]]$Only,[string]$PackageRoot)
$ErrorActionPreference='Stop'
$repo=[IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
if(-not $PackageRoot){$PackageRoot=Join-Path $repo 'outputs\native-keyboards'}
$work=Join-Path $repo 'work\native-keyboards\setup'
New-Item -ItemType Directory -Path $work -Force | Out-Null
$catalog=Get-Content (Join-Path $PSScriptRoot 'layouts.json') -Raw -Encoding UTF8 | ConvertFrom-Json
$translations=Get-Content (Join-Path $PSScriptRoot 'setup-translations.json') -Raw -Encoding UTF8 | ConvertFrom-Json
$compiler=Join-Path $env:SystemRoot 'Microsoft.NET\Framework\v4.0.30319\csc.exe'
foreach($layout in $catalog){
    if($Only -and $layout.slug -notin $Only){continue}
    $dir=Join-Path $PackageRoot $layout.slug
    foreach($suffix in @('_i386.msi','_amd64.msi')){
        if(-not (Test-Path -LiteralPath (Join-Path $dir ($layout.name+$suffix)))){throw ('Missing MSI: '+$layout.slug)}
    }
    $config=Join-Path $work ($layout.name+'.json')
    @{layout=$layout;texts=$translations} | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $config -Encoding UTF8
    $exe=Join-Path $dir 'setup.exe'
    & $compiler /nologo /target:winexe /platform:anycpu /optimize+ "/out:$exe" /reference:System.Windows.Forms.dll "/win32manifest:$(Join-Path $PSScriptRoot 'setup.manifest')" "/resource:$config,setup-config.json" "/resource:$(Join-Path $PSScriptRoot 'setup-ui.ps1'),setup-ui.ps1" "/resource:$(Join-Path $PSScriptRoot 'setup-core.ps1'),setup-core.ps1" (Join-Path $PSScriptRoot 'SetupLauncher.cs')
    if($LASTEXITCODE -ne 0){throw ('Setup compilation failed: '+$layout.slug)}
    Write-Output ('SETUP '+$layout.slug)
}
