<# : batch portion
@echo off  && title Initialization.. && (for %%I in ("%~f0";%*) do @echo(%%~I) | powershell.exe -noprofile -command "$argv = $input | ?{$_}; iex (${%~f0} | out-string)" && exit /b
: end batch / begin powershell #>

$Preferences = @{

    AutoStart = $False
        # If you prefer to start upscaling as soon as you launch the batchfile, instead of being prompted to upscale/open settings

    'Encoding Arguments' = 'H264 CPU'
        # You can add simple arguments by combining them with a space:
        # Support codecs: H264 (AVC), H265 (HEVC)
        # Supported encoders: NVENC (NVIDIA), AMF (AMD), QuickSync (Intel), CPU
        # Remember it's codec THEN encoder, example: H264 NVENC

    'Scaling Filter' = 'Point'
        # Recommended values: FSRCNNX, Lanczos, HQX, Point

    'Target Height' = 2160
        # Nothing else than 4K (2160p) is recommended

    'Output Extension' = '.mkv'

    Extensions = @('.mp4','.mkv','.avi','.mov','.webm')
    Verbose = $False

}

<#
   The rest of this file is part of the script, don't mess with it unless you know what you're doing
#>



$Presets = @{

    H264 = @{
        NVENC =       "h264_nvenc -preset p7 -rc vbr -b:v 250M -cq 18"
        AMF =         "h264_amf -quality quality -qp_i 12 -qp_p 12 -qp_b 12"
        QuickSync =   "h264_qsv -preset veryslow -global_quality:v 15"
        CPU =         "libx264 -preset slower -x264-params aq-mode=3 -crf 15 -pix_fmt yuv420p10le"
    }
    H265 = @{
        NVENC =       "hevc_nvenc -preset p7 -rc vbr -b:v 250M -cq 18"   
        AMF =         "hevc_amf -quality quality -qp_i 16 -qp_p 18 -qp_b 20"
        QuickSync =   "hevc_qsv -preset veryslow -global_quality:v 18"
        CPU =         "libx265 -preset slow -x265-params aq-mode=3 -crf 18 -pix_fmt yuv420p10le"
    }
}

function PauseNul {
    ''
    Pause
}

if ($Preferences.Verbose -eq $true) {$VerbosePreference = 'Continue'}

function Set-Title ($Title){$Host.UI.RawUI.WindowTitle = $Title}

Set-Title 'CTT Upscaler - Initializing..'

$ScriptDir = (Get-Item $argv | Select-Object -First 1).Directory.FullName

#if ($ScriptDir -ne [System.Environment]::GetFolderPath('SendTo')){
#    [System.Environment]::GetFolderPath('SendTo')
#    $ScriptDir
#    Write-Warning "WARNING: Script is not in SendTo folder"
#    Start-Sleep -Seconds 2
#}

if ($argv.count -eq 1){
    Write-Output @"
No input file specified, in order to do this you NEED to queue videos this way:

1. Find one (or multiple) video(s) to queue
2. Select, then right click any of them
3. Click on "Send To", then select "CTT Upscaler"
"@
pause
exit
}

if (-Not($Preferences.AutoStart)){
    if(-Not($Verbose)){Clear-Host}
    Set-Title "[$($argv.Count-1) queued] CTT Upscaler - Menu"

    function CenterText($Message){

        for($i = 0; $i -lt (([Math]::Max(0, $Host.UI.RawUI.BufferSize.Width / 2) - [Math]::Max(0, $Message.Length / 2))) - 4; $i++)
        {
            $string += " "
        }

        $string += $Message

        for($i = 0; $i -lt ($Host.UI.RawUI.BufferSize.Width - ((([Math]::Max(0, $Host.UI.RawUI.BufferSize.Width / 2) - [Math]::Max(0, $Message.Length / 2))) - 2 + $Message.Length)) - 2; $i++)
        {
            $string += " "
        }
        return $string

    }
    @(
    ''
    '            .~7??????????????????????7~:    '
    '          ^5#@@@@@@@@@@@@@@@@@@@@@@@@@@&P~  '
    '         !&@@@@@@@@@@@@@@@@@@@@@BGBBBB@@@@? '
    '         B@@@@@@@@@@@@@@@@@@@@@&?!~   P@@@&:'
    '        .B@@@@@@@@@@@@@@@@@@@@@@&Y:~  5@@@&^'
    '        .B@@@@@@@@@@@@@@@@@@@@&J:^P@5 P@@@&:'
    '        .B@@@@@@@@@@@@@@@@@@#?:~P@@@&B@@@@&:'
    '        .B@@@@@@@@@@@@@@@@#?.~G@@@@@@@@@@@&:'
    '        .B@@@@@@@@@@@@@@B7.!G@@@@@@@@@@@@@&:'
    '        .B@@@@@@@@@@@@B!.!B@@@@@@@@@@@@@@@&:'
    '        .B@@@@@@@@@@G!.7B@@@@@@@@@@@@@@@@@&:'
    '         #@@@@@@@@G~.?#@@@@@@@@@@@@@@@@@@@&:'
    '  .~!7!!75PPPPG#@?:?#@@@@@@@@@@@@@@@@@@@@@&:'
    '.J#@@@@@@^     .7B&@@@@@@@@@@@@@@@@@@@@@@@&:'
    '?@@@@@@@@J       7@@@@@@@@@@@@@@@@@@@@@@@@P '
    'Y@@@@@@@@@Y:     ~@@@@@@@@@@@@@@@@@@@@@@&Y. '
    'Y@@@@@@@@@@&P?~^^7BBBBBBBBBBBBBBBBBBBG57:   '
    'Y@@@@@@@@@@@@@@@@G                          '
    'Y@@@@@@@@@@@@@@@@B                          '
    '!@@@@@@@@@@@@@@@@J                          '
    ' ~5B&&&&&&&&&&#P!                           '
    '  ?@@@@@@@@@@@@:                            '
    ''
   '[U]pscale'
   'Open [S]ettings'
   ''
   'Type any key in square brackets to get started'
   ''
    ) | ForEach-Object {CenterText $_}

    $Answer = Read-Host "Choice"
	
    switch ($Answer){ # Can't use choice.exe for some reason
        {$_ -in '','U','Upscale', '[U]'}{}
        {$_ -in 'S', 'Settings', 'Open Settings', 'Open [S]ettings', '[S]'} {
            try { 
                [string] $Class = ((Get-Item "Registry::HKEY_CLASSES_ROOT\.txt\OpenWithProgids") | Select-Object -First 1).Property
                [string] $Path = "Registry::HKEY_CLASSES_ROOT\$Class\shell\open\command"
                [string] $Command = (Get-ItemPropertyValue -Path $Path -Name "(Default)")
                Invoke-Expression "& $($Command.Replace("%1", ($argv | Select-Object -First 1)))"
            }
            catch {}
            exit
        }
        'q'{exit}
    }
}

function CheckScoop {
    if (-Not(Get-Command scoop.cmd -Ea Ignore)){
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        $RunningAsAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')
        
        if (-Not($RunningAsAdmin)){
            Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh'))
        }else{
            Invoke-Expression "& {$(((New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')))} -RunAsAdmin"
        }
    }
}

switch ($Preferences.'Scaling filter'){
    'HQX' {$vf = 'hqx={0},scale=out_color_matrix=bt709 -pix_fmt yuv420p -colorspace bt709'} 
    'XBR' {$vf = 'xbr={0},scale=out_color_matrix=bt709 -pix_fmt yuv420p -colorspace bt709'} # ty meom
    'Lanczos' {$vf = "zscale=-2:$($Preferences.'Target Height'):f=lanczos"}
    'Bilinear' {$vf = "zscale=-2:$($Preferences.'Target Height'):f=bilinear"}
    'Bicubic' {$vf = "zscale=-2:$($Preferences.'Target Height'):f=bicubic"}
    'Point' {$vf = "zscale=-2:$($Preferences.'Target Height'):f=point"}
    'Spline36' {$vf = "zscale=-2:$($Preferences.'Target Height'):f=spline36"}
    'FSRCNNX' {

        Set-Location $ScriptDir

        if (-Not(Test-Path "$ScriptDir\FSRCNNX.glsl")){

            $FSRCNNX_url = (Invoke-RestMethod https://api.github.com/repos/igv/FSRCNN-TensorFlow/releases/latest).assets |
            ForEach-Object {$_.browser_download_url} | Where-Object {$_ -Like "*_x2_16-*"}

            Invoke-WebRequest -UseBasicParsing $FSRCNNX_url -OutFile ".\FSRCNNX.glsl"
        
            (Get-Item ".\FSRCNNX.glsl").Attributes += 'Hidden' # Hides FSRCNNX.glsl from the Send To list
        
        }

        $init = '-init_hw_device vulkan'
        $vf = "format=yuv420p,hwupload,`"libplacebo=w=-2:h=$($Preferences.'Target Height'):custom_shader_path=FSRCNNX.glsl`",hwdownload,format=yuv420p"
    }
}

$EZEncArgs = $Preferences.'Encoding Arguments' -Split ' '
if ($EZEncArgs.Count -eq 2){

    switch ($EZEncArgs[0]){
        {$_ -in 'HEVC', 'H265', 'H.265'}{$Codec = 'H265'}
        {$_ -in 'AVC', 'H264', 'H.264'}{$Codec = 'H264'}
    }

    switch ($EZEncArgs[1]){
        {$_ -in 'NVIDIA', 'NV', 'NVENC'}{$script:Encoder = 'NVENC'}
        {$_ -in 'AMF', 'AMD'}{$script:Encoder = 'AMF'}
        {$_ -in 'x264', 'libx264', 'CPU'}{$script:Encoder = 'CPU'}
        {$_ -in 'QuickSync', 'Intel', 'QS'}{$script:Encoder = 'QuickSync'}
    }

    $EncArgs = $Presets.$Codec.$Encoder
}else{
    $EncArgs = $Preferences.'Encoding Arguments'
}

$Videos = Get-ChildItem $argv | Select-Object -Skip 1 | Where-Object {$_.Extension -in $Preferences.Extensions}
$Round = 0

$Videos | ForEach-Object {

    if(-Not($Verbose)){Clear-Host}
    $Round++

    if ($Codec -And $Encoder){ # Then it uses EZEncArgs
        Write-Output @"

    > Codec: $Codec
    > Encoder: $Encoder
    > Filename: $($_.Name)
    > Scaling filter: $($Preferences.'Scaling filter')

"@
    }

    Set-Title "[$Round/$($Videos.Count)] CTT Upscaler - Upscaling $($_.Name)"

    $Metadata = ((ffprobe.exe -v quiet -print_format json -show_format -show_streams `"$($_.FullName)`") | ConvertFrom-Json).Streams

    if ($Preferences.'Scaling filter' -in 'HQX','XBR'){
        
        $Factor =  0
        $VideoHeight = ([int]($Metadata.Height | Select-Object -First 1))

        While ([int]($Preferences.'Target Height') -gt ([int]($VideoHeight) * [int]$Factor)){
            $Factor++
        }
        if ($Preferences.Verbose){"Factor: $Factor"}
        $vf = $vf -f $Factor
    }


    if ($Metadata.Height -ge 2160){
        "Video is already 4K or above, press any key to exit.."
        PauseNul
        exit
    }

    $VideoFPS = Invoke-Expression ($Metadata.avg_frame_rate | Select-Object -First 1) # Get object that contains FPS, then divides to real vlaue (e.g 120/2 or smth)
    
    if ($VideoFPS -gt 65){
    Write-Output @"
Video is above 60fps, here's a reminder:

Upscaling is meant for helping with bitrate on YouTube, which only supports 60FPS or below content
If you upload a video above 60FPS, it'll get it's framerate capped to 60FPS

"@
    $Metadata | Select-Object r_frame_rate, avg_frame_rate
    PauseNul
    }

    $Out = Join-Path (Get-Item $_).Directory.FullName ($_.BaseName + ' - Upscaled.mp4')

    if (Get-Command ffprogress.exe -Ea Ignore){$process = 'ffprogress.exe'}
    else{$process = 'ffmpeg.exe'}

    $Command = "$process -loglevel error -stats $init -i `"$($_.FullName)`" -vf $vf -c:v $EncArgs -c:a copy `"$Out`" -y"
    if ($Preferences.Verbose){Write-Output $Command}
    Invoke-Expression $Command
    
    if ($LASTEXITCODE -ne 0){
        ''
        Write-Host 'Something went wrong, pausing..&' -ForegroundColor Red
        PauseNul
    }

}