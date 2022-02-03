<# : batch portion
@echo off & (for %%I in ("%~f0";%*) do @echo(%%~I) | ^
powershell.exe -noprofile -command "$argv = $input | ?{$_}; iex (${%~f0} | out-string)"
: end batch / begin powershell #>

#INSTALLER_START
if (-Not($argv)){ # Trigger self-installation script, this file contains both it's installer and the upscale script itself

    if (-Not(Get-Command scoop.cmd -Ea Ignore)){
        Set-ExecutionPolicy Bypass -Scope Process -Force;
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh'))

    }

    if(Get-Command ffmpeg  -Ea Ignore){
        if ((ffmpeg -hide_banner -h filter=libplacebo) -eq "Unknown filter 'libplacebo'."){ # Check if libplacebo is installed, therefore if ffmpeg is atleast version 5.0 s/o vlad
            if ((Get-Command ffmpeg).Source -like "*\shims\*"){
                scoop.cmd update ffmpeg
            }else{
                scoop.cmd install ffmpeg
            }
        }
    }else{
        scoop.cmd install ffmpeg
    }

    if (-Not(Get-Command git -Ea Ignore)){
        scoop.cmd install main/git
    }

    $buckets = Join-Path (Get-Item (Get-Command scoop.cmd).Source).Directory.Parent.FullName 'buckets'

    if (-Not (Test-Path "$buckets\utils")){
        scoop.cmd bucket add  utils https://github.com/couleur-tweak-tips/utils
    }

    if (-Not(Get-Command ffprogress -Ea Ignore)){
        scoop.cmd bucket add utils/ffprogress
    }
    @(
        'hevc_nvenc -rc constqp -preset p7 -qp 18'
        'h264_nvenc -rc constqp -preset p7 -qp 15'
        'hevc_amf -quality quality -qp_i 16 -qp_p 18 -qp_b 20'
        'h264_amf -quality quality -qp_i 12 -qp_p 12 -qp_b 12'
        'hevc_qsv -preset veryslow -global_quality:v 18'
        'h264_qsv -preset veryslow -global_quality:v 15'
        'libx265 -preset medium -crf 18'
        '-c:v libx264 -preset slow -crf 15'
    ) | ForEach-Object -Begin {
        $shouldStop = $false
    } -Process {
        if ($shouldStop -eq $true) { return }
        Invoke-Expression "ffmpeg.exe -loglevel warning -f lavfi -i nullsrc=3840x2160 -t 0.1 -c:v $_ -f null NUL"
        if ($LASTEXITCODE -eq 0){
            $script:valid_args = $_
            $shouldStop = $true # Crappy way to stop the loop since most people that'll execute this will technically be parsing the raw URL as a scriptblock

        }
    }

    Write-Warning "Dependencies installed"

    $SendTo = [Environment]::GetFolderPath('SendTo')

    if (Test-Path "$SendTo\FSRCNNX.glsl"){Remove-Item "$SendTo\FSRCNNX.glsl" -Force -Ea Continue}

    $FSRCNNX_url = (Invoke-RestMethod https://api.github.com/repos/igv/FSRCNN-TensorFlow/releases/latest).assets | ForEach-Object {$_.browser_download_url} | Where-Object {$_ -Like "*_x2_16-*"}

    Invoke-RestMethod $FSRCNNX_url -OutFile "$SendTo\FSRCNNX.glsl"

    (Get-Item "$SendTo\FSRCNNX.glsl").Attributes += 'Hidden' # Hides FSRCNNX.glsl from the Send To list

    $Script = Invoke-RestMethod https://raw.githubusercontent.com/couleur-tweak-tips/utils/main/Miscellaneous/CTT%20Upscaler.bat

    $Script = $Script.Split([System.Environment]::NewLine)

    $Start = [array]::IndexOf($Script,'#INSTALLER_START') -1
    $End = [array]::IndexOf($Script,'#INSTALLER_END') + 1
    $ScriptEnd = [array]::indexof($Script,$Script[-1])

    $Script = $Script[0..$Start] + $Script[$End..$ScriptEnd]

    Set-Content -Path (Join-Path $SendTo 'CTT Upscaler.cmd') -Value ($Script -replace '$null',"'$valid_args'")

    Write-Warning "CTT Upscaler has been added to your Send To folder, you can now right click any video, select Send To -> CTT Upscaler to upscale it"
    pause
    exit
}
#INSTALLER_END

$enc_args = 'hevc_nvenc -rc constqp -preset p7 -qp 18'

Set-Location ($argv[0] | Split-Path)
$videos = $argv | Select-Object -Skip 1

if (-Not($videos)){
    "No videos queued, exitting.."
    Start-Sleep 3
    exit
}

Get-ChildItem $videos | ForEach-Object {
    $out = Join-Path (Get-Item $_).Directory.FullName ($_.BaseName + ' - Upscaled.mp4')
    $vf = 'format=yuv420p,hwupload,"libplacebo=w=-2:h=2160:custom_shader_path=FSRCNNX_x2_16-0-4-1.glsl",hwdownload,format=yuv420p'
    $command = "ffmpeg -init_hw_device vulkan -i `"$_`" -vf $vf -c:v $enc_args -c:a libopus -b:a 128k `"$out`""
    Write-Verbose "$command" -verbose
    Invoke-Expression $command
}

if ((Get-Command ffplay -Ea Ignore) -and (Test-Path "$env:windir\Media\ding.wav")){

    ffplay "$env:WINDIR\Media\ding.wav" -volume 20 -autoexit -showmode 0 -loglevel quiet
}
Start-Sleep -Seconds 3
exit