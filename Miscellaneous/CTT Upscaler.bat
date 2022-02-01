<# : batch portion
@echo off & (for %%I in ("%~f0";%*) do @echo(%%~I) | ^
powershell.exe -noprofile -command "$argv = $input | ?{$_}; iex (${%~f0} | out-string)"
: end batch / begin powershell #>

if (-Not($argv)){ # Trigger self-installation script, this file contains both it's installer and the upscale script itself
    function Get-Path ($FileName){

        if (-Not(Get-Command $FileName -ErrorAction SilentlyContinue)){return $null}
    
        switch ($FileName.Split('.')[1]){
            'shim'{
                $Path = ((Get-Content ((Get-Command -ErrorAction SilentlyContinue).source)) -split ' = ')[1]
            }
            'exe'{
    
                $BaseName = $FileName.Split('.')[0]
    
                if (Get-Command "$BaseName.shim" -ErrorAction SilentlyContinue){
    
                    $Path = ((Get-Content ((Get-Command "$BaseName.shim").source)) -split 'path = ')[1]
    
                }else{$Path = (Get-Command $FileName).source}
            }
        }
    
        if(-Not($Path)){$Path = (Get-Command $FileName).Source}
    
        return $Path
    
    }

    if (-Not(Get-Path scoop.cmd)){
        Set-ExecutionPolicy Bypass -Scope Process -Force;
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh'))

    }

    if(Get-Path ffmpeg){
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

    if (-Not(Get-Path git)){
        scoop.cmd install main/git
    }

    $buckets = Join-Path (Get-Item (Get-Command scoop.cmd).Source).Directory.Parent.FullName 'buckets'

    if (-Not (Test-Path "$buckets\utils")){
        scoop.cmd bucket add  utils https://github.com/couleur-tweak-tips/utils
    }

    if (-Not(Get-Path ffprogress)){
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
    ) | ForEach-Object{
        Invoke-Expression "ffmpeg.exe -loglevel warning -f lavfi -i nullsrc=3840x2160 -t 0.1 -c:v $_ -f null NUL"
        if ($LASTEXITCODE -eq 0){
            $script:valid_args = $_
            break

        }
    }

    $SendTo = [Environment]::GetFolderPath('SendTo')

    $FSRCNNX_url = (Invoke-RestMethod https://api.github.com/repos/igv/FSRCNN-TensorFlow/releases/latest).assets | ForEach-Object {$_.browser_download_url} | Where-Object {$_ -Like "*_x2_16-*"}

    Invoke-RestMethod $FSRCNNX_url -OutFile "$SendTo\FSRCNNX.glsl"

    (Get-Item "$SendTo\FSRCNNX.glsl").Attributes += 'Hidden' # Hides FSRCNNX.glsl from the Send To list

    $Script = Invoke-RestMethod https://raw.githubusercontent.com/couleur-tweak-tips/utils/main/Miscellaneous/CTT%20Upscaler%20%5B2.0%5D.cmd

    Set-Content -Path (Join-Path $SendTo 'CTT Upscaler.cmd') -Value ($Script -replace '$null',"'$valid_args'")
}


$enc_args = 'hevc_nvenc -rc constqp -preset p7 -qp 18'

Set-Location ($argv[0] | Split-Path)
$videos = $argv | Select-Object -Skip 1

Get-ChildItem $videos | ForEach-Object {
    $out = Join-Path (Get-Item $_).Directory.FullName ($_.BaseName + ' - Upscaled.mp4')
    $vf = 'format=yuv420p,hwupload,"libplacebo=w=-2:h=2160:custom_shader_path=FSRCNNX_x2_16-0-4-1.glsl",hwdownload,format=yuv420p'
    $command = "ffmpeg -init_hw_device vulkan -i `"$_`" -vf $vf -c:v $enc_args -c:a libopus -b:a 128k `"$out`""
    Write-Verbose "$command" -verbose
    Invoke-Expression $command
}

if ((Get-Path ffplay) -and (Test-Path "$env:windir\Media\ding.wav")){

    ffplay "$env:WINDIR\Media\ding.wav" -volume 20 -autoexit -showmode 0 -loglevel quiet
}
Start-Sleep -Seconds 3
exit