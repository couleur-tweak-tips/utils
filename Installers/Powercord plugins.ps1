if (-Not(Test-Path "~\powercord\src\Powercord\plugins")){

    "Powercord is not installed or not installed to $env:USERPROFILE\powercord\src\Powercord\plugins"
    timeout 10 | Out-Null
    exit

}

Set-Location "~\powercord\src\Powercord\plugins"


@(
    'https://github.com/RazerMoon/vcTimer',
    'https://github.com/RazerMoon/muteNewGuild',
    'https://github.com/E-boi/powercord-LinkChannels',
    'https://github.com/RazerMoon/hidechannels',
    'https://github.com/BenSegal855/powerclock',
    'https://github.com/Juby210/view-raw'

) | ForEach-Object {git clone $PSItem}
@"

Finished
"@
timeout 15 | Out-Null
exit