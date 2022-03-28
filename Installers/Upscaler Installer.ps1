# CTT Upscaler Installer
Set-ExecutionPolicy Bypass -Scope Process -Force

if (-Not(Get-Command scoop -Ea Ignore)){
    
    $RunningAsAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')

    If (-Not($RunningAsAdmin)){
        Invoke-Expression (Invoke-RestMethod -Uri http://get.scoop.sh)
    }else{
        Invoke-Expression "& {$(Invoke-RestMethod -Uri https://get.scoop.sh)} -RunAsAdmin"
    }
}

$IsFFmpegScoop = (Get-Command ffmpeg -Ea Ignore).Source -Like "*\shims\*"

if(Get-Command ffmpeg -Ea Ignore){

    $IsFFmpeg5 = (ffmpeg -hide_banner -h filter=libplacebo)

    if (-Not($IsFFmpeg5)){

        if ($IsFFmpegScoop){
            scoop update ffmpeg
        }else{
            Write-Warning @"
An FFmpeg installation was detected, but it is not version 5.0 or higher.
If you installed FFmpeg yourself, you can remove it and use the following command to install ffmpeg and add it to the path:

scoop install ffmpeg

You can find a tutorial to install FFmpeg manually here: 

https://www.youtube.com/watch?v=WwWITnuWQW4

"@
pause
exit      
        }
        
    }
            
}else{
    scoop install ffmpeg
}

$DriverVersion = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}_Display.Driver" -ErrorAction Ignore).DisplayVersion
    if ($DriverVersion){ # Only triggers if it parsed a NVIDIA driver version
        if ($DriverVersion -lt 477.41){ # Oldest NVIDIA version capable
        Write-Warning "Outdated NVIDIA Driver version detected ($DriverVersion), NVIDIA settings won't be available until you upgrade your drivers"
    }
}

$ST = [System.Environment]::GetFolderPath('SendTo')
Invoke-RestMethod `
-Uri 'https://github.com/couleur-tweak-tips/utils/raw/main/Miscellaneous/CTT%20Upscaler.bat' `
-OutFile "$ST\CTT Upscaler.cmd"

Write-Host @"
CTT Upscaler has been installed,

I strongly recommend you open settings to tune it to your PC, there's lots of cool stuff to do there!
"@ -ForegroundColor Green
