param([Parameter(Mandatory=$true)][string]$OutputRoot,[string]$ReleaseBodyPath)
$ErrorActionPreference='Stop'
$data=Get-Content (Join-Path $PSScriptRoot 'release-notes-translations.json') -Raw -Encoding UTF8 | ConvertFrom-Json
$version=[string]$data.version
if($version -notmatch '^v\d+\.\d+\.\d+$'){throw 'Invalid release notes version'}
$languages=[ordered]@{
    es='Español';en='English';fr='Français';de='Deutsch';it='Italiano';pt='Português';
    nb='Norsk bokmål';da='Dansk';ru='Русский';uk='Українська';be='Беларуская'
}
function Get-NotesName([string]$Code){
    if($Code -eq 'en'){return ('RELEASE_NOTES_'+$version+'.md')}
    return ('RELEASE_NOTES_'+$version+'.'+$Code+'.md')
}
$selector=($languages.Keys | ForEach-Object {'['+$languages[$_]+']('+(Get-NotesName $_)+')'}) -join ' · '
$utf8=[Text.UTF8Encoding]::new($true)
New-Item -ItemType Directory -Path $OutputRoot -Force | Out-Null
foreach($code in $languages.Keys){
    $t=$data.languages.$code
    foreach($field in @(@('headings',5),@('installer',6),@('reliability',3),@('compatibility',2),@('validation',4),@('downloads',2))){
        if(@($t.($field[0])).Count -ne $field[1] -or @($t.($field[0]) | Where-Object {-not $_}).Count){throw ('Incomplete release notes: '+$code+' '+$field[0])}
    }
    if(-not $t.title -or -not $t.upgrade){throw ('Incomplete release notes: '+$code)}
    $lines=New-Object 'Collections.Generic.List[string]'
    $lines.Add('# '+$version+' — '+$t.title)
    $lines.Add($selector)
    foreach($section in @(@(0,'installer'),@(1,'reliability'),@(2,'compatibility'),@(3,'validation'),@(4,'downloads'))){
        $lines.Add('## '+$t.headings[$section[0]])
        $items=@($t.($section[1]))
        if($section[1] -in @('installer','reliability','validation')){
            $lines.Add((($items | ForEach-Object {'- '+$_}) -join "`n"))
        }else{foreach($paragraph in $items){$lines.Add($paragraph)}}
        if($section[1] -eq 'validation'){$lines.Add($t.upgrade)}
    }
    [IO.File]::WriteAllText((Join-Path $OutputRoot (Get-NotesName $code)),($lines -join "`n`n")+"`n",$utf8)
}
if($ReleaseBodyPath){
    $links=($languages.Keys | ForEach-Object {
        '['+$languages[$_]+'](https://github.com/palmaner/angle-quotes-keyboards/blob/'+$version+'/docs/'+(Get-NotesName $_)+')'
    }) -join ' · '
    $body=@(
        'Native Windows keyboard layouts with an optional default-keyboard checkbox. Reopen `setup.exe` to restore your preceding preference, or uninstall from the same window.'
        'Existing v0.1.0 installations are recognized. Keyboard mappings and MSI packages are unchanged; this release updates the setup interface and documentation.'
        '### Notas de versión / Release notes'
        $links
        '### Downloads'
        'Download `ANGLE_QUOTES_NATIVE_WINDOWS.zip` for all layouts or the individual ZIP for yours. Extract the complete ZIP and keep its files together. `SHA256SUMS.txt` lists the hashes for the 18 ZIP files. The GitHub **Source code** archives are not the packaged installer downloads.'
        'Windows x86/x64; ARM64 is not included. Installers are unsigned; Windows may show a SmartScreen warning. See the release notes for validation scope and limitations.'
    ) -join "`n`n"
    New-Item -ItemType Directory -Path (Split-Path -Parent ([IO.Path]::GetFullPath($ReleaseBodyPath))) -Force | Out-Null
    [IO.File]::WriteAllText([IO.Path]::GetFullPath($ReleaseBodyPath),$body+"`n",$utf8)
}
Write-Output ('Generated '+$languages.Count+' release notes: '+$version)
