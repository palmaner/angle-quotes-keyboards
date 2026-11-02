param(
    [Parameter(Mandatory=$true)][string]$OutputRoot,
    [switch]$AllowPendingVideo
)
$ErrorActionPreference='Stop'
$video=Get-Content (Join-Path $PSScriptRoot 'tutorial-video.json') -Raw -Encoding UTF8 | ConvertFrom-Json
$videoUrl=[string]$video.url
if($videoUrl -and $videoUrl -notmatch '^https://github\.com/user-attachments/assets/[0-9a-fA-F-]{36}$'){throw 'Invalid GitHub video attachment URL'}
if(-not $videoUrl -and -not $AllowPendingVideo){throw 'Upload the approved tutorial and set tutorial-video.json before generating public README files. Use -AllowPendingVideo for local preparation only.'}
$catalog=Get-Content (Join-Path $PSScriptRoot 'layouts.json') -Raw -Encoding UTF8 | ConvertFrom-Json
$translations=Get-Content (Join-Path $PSScriptRoot 'readme-translations.json') -Raw -Encoding UTF8 | ConvertFrom-Json
$languages=[ordered]@{
    es='Español';en='English';fr='Français';de='Deutsch';it='Italiano';pt='Português';
    nb='Norsk bokmål';da='Dansk';ru='Русский';uk='Українська';be='Беларуская'
}
$links=foreach($code in $languages.Keys){
    $file=if($code -eq 'en'){'README.md'}else{'README.'+$code+'.md'}
    '['+$languages[$code]+']('+$file+')'
}
$selector=$links -join ' · '
$utf8=[Text.UTF8Encoding]::new($true)
New-Item -ItemType Directory -Path $OutputRoot -Force | Out-Null
foreach($code in $languages.Keys){
    $t=$translations.$code
    if(-not $t -or $t.names.Count -ne $catalog.Count -or $t.columns.Count -ne 3){throw ('Incomplete translation: '+$code)}
    $lines=New-Object 'Collections.Generic.List[string]'
    $lines.Add('# '+$t.title)
    $lines.Add($selector)
    $lines.Add($t.intro)
    $lines.Add($t.overview)
    $lines.Add('**['+$t.download+'](https://github.com/palmaner/angle-quotes-keyboards/releases/latest)** · ['+$t.issue+'](https://github.com/palmaner/angle-quotes-keyboards/issues)')
    if(-not $t.videoTitle -or -not $t.videoNote){throw ('Missing video translation: '+$code)}
    $lines.Add('## '+$t.videoTitle)
    $lines.Add($t.videoNote)
    if($videoUrl){$lines.Add('<'+$videoUrl+'>')}
    else{$lines.Add('<!-- Video attachment pending upload approval. -->')}
    $lines.Add('## '+$t.choose)
    $lines.Add($t.chooseNote)
    $table=New-Object 'Collections.Generic.List[string]'
    $table.Add('| '+($t.columns -join ' | ')+' |')
    $table.Add('| --- | --- | --- |')
    $groups=@(
        [pscustomobject]@{Indices=@(0,1,2,3,4,5,6)},
        [pscustomobject]@{Indices=@(7,11)},
        [pscustomobject]@{Indices=@(12,13,14)},
        [pscustomobject]@{Indices=@(8,9,10)},
        [pscustomobject]@{Indices=@(15,16)}
    )
    foreach($group in $groups){
        $layout=$catalog[$group.Indices[0]]
        $opening=[char][Convert]::ToInt32($layout.keys.'06',16)
        $closingProperty=if($layout.keys.PSObject.Properties['08']){'08'}else{'07'}
        $digit=if($closingProperty -eq '08'){7}else{6}
        $closing=[char][Convert]::ToInt32($layout.keys.$closingProperty,16)
        $layoutLinks=foreach($i in $group.Indices){
            '['+$t.names[$i]+']('+$catalog[$i].slug+'/README.txt)'
        }
        $prefix=if($group.Indices[0] -eq 15){'**'+$t.experimentalLabel+':** '}else{''}
        $table.Add('| '+$prefix+($layoutLinks -join ', ')+' | AltGr+5 → '+$opening+' | AltGr+'+$digit+' → '+$closing+' |')
    }
    $lines.Add(($table -join "`r`n"))
    $lines.Add($t.experimentalNote)
    foreach($section in @(@('installTitle','install'),@('changesTitle','changes'),@('removeTitle','remove'),@('practiceTitle','practice'),@('statusTitle','status'))){
        if(-not $t.($section[0]) -or -not $t.($section[1])){throw ('Missing section in '+$code)}
        $lines.Add('## '+$t.($section[0]))
        $lines.Add($t.($section[1]))
    }
    $lines.Add($t.license)
    $lines.Add($t.maintainers)
    $body=($lines -join "`r`n`r`n")+"`r`n"
    $fileName=if($code -eq 'en'){'README.md'}else{'README.'+$code+'.md'}
    [IO.File]::WriteAllText((Join-Path $OutputRoot $fileName),($body -replace "`r?`n","`n"),$utf8)
}
