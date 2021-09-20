@echo off & title El Upscaler -coul,vlad & (color 0F)
:start
:: For anyone reading this script, a reminder:
::
:: Upscaling does not make your video look better,
:: it just forces YouTube to give your video more bitrate.

:::::::::::::::::::::::::: OPTIONS ::::::::::::::::::::::::::

set ForceEncoder=AUTOMATIC
::Supported encoders: NVIDIA, AMD, INTEL, CPU

set codec=HEVC
:: HEVC for better efficiency, AVC for compatibility

set ShowCommand=FALSE
:: Set to YES if you wish to show what command FFmpeg is gonna run
:: (Often used for troubleshooting)

set EnableCPUWarning=YES
:: If you're annoyed of the warning and all you got is a CPU, put that to NO

::FactorAlgo (2x, 3x, 4x) will apply only for 960x540/1280x720/1920x1080
set factoralgo=hqx
::StretchAlgo will apply for every other 'odd' resolution
set stretchalgo=lanczos

:: Supported
set cpupreset=fast
set container=mp4

::
:: Advanced options
::

set FFmpegUnusualVersionWarning=true


set targetresolution=2160
set forcepreset=no
set forcequality=no
set presetcommand=-preset
set forcedencoderopts=no
:: Warning & explanation incase of if unproper use of SendTo
if /I %1check == check (
	color 4F
    title ERROR: no input file - unproper use of SendTo
    echo In order to be used properly, this batchfile needs to be in the SendTo folder,
    echo After that, right click on your video, go over to Send To and select the .bat
	echo.
	echo Press any key to move the script to the SendTo folder.
    pause > nul
	move %~0 %appdata%\Microsoft\Windows\SendTo
    exit
)

if /I "%ShowCommand%"=="YES" (set ShowCommand= )
if /I "%ShowCommand%"=="NO" (set ShowCommand=::)

::GPU detection to get the correct encoder
for /f "tokens=* skip=1" %%n in ('WMIC path Win32_VideoController get Name ^| findstr "."') do set GPU_NAME=%%n
set GPU_NAME=%GPU_NAME: =%
if /I "%gpu_name:NVIDIA=%" neq "%gpu_name%" (set hwaccel=NVENC& goto :ffmpegcheck)
if /I "%gpu_name:AMD=%" neq "%gpu_name%" (set hwaccel=amd& goto :ffmpegcheck)
if /I "%gpu_name:RADEON=%" neq "%gpu_name%" (set hwaccel=amd& goto :ffmpegcheck)
if /I "%gpu_name:VEGA=%" neq "%gpu_name%" (set hwaccel=amd& goto :ffmpegcheck)
if /I "%gpu_name:INTEL=%" neq "%gpu_name%" (set hwaccel=Intel& goto :ffmpegcheck)
if /I '%hwaccel%'=='AUTOMATIC' (set hwaccel=%ForceEncoder%) & (goto :ffmpegcheck)
set hwaccel=CPU & goto :ffmpegcheck

:ffmpegcheck
if exist %chocolateyinstall%\bin\ffmpeg.exe (goto Resolution)
where ffmpeg>nul 2>nul
if '%ERRORLEVEL%'=='0' (
if /I '%FFmpegUnusualVersionWarning%'=='true' (
echo The upscaler might not work if you are using an older FFmpeg version
echo.
echo You can disable this warning by opening the script and setting the FFmpegUnusualVersionWarning variable to false
pause
goto Resolution
))
echo FFmpeg not installed/added to path, installing..
timeout 2>nul
:init
 setlocal DisableDelayedExpansion
 set cmdInvoke=1
 set winSysFolder=System32
 set "batchPath=%~0"
 for %%k in (%0) do set batchName=%%~nk
 set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
 setlocal EnableDelayedExpansion
:checkPrivileges
  NET FILE 1>NUL 2>NUL
  if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )
:getPrivileges
  if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
  ECHO args = "" >> "%vbsGetPrivileges%"
  ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
  ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
  ECHO Next >> "%vbsGetPrivileges%"
  if '%cmdInvoke%'=='1' goto InvokeCmd
  ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
  goto ExecElevation
:InvokeCmd
  ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
  ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"
:ExecElevation
 "%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
 exit /B
:gotPrivileges
 setlocal & cd /d %~dp0
 if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
:: yes I've tried different ways, I know this is scuffed but it works :shrug: -coul
if exist %chocolateyinstall%\bin\chocolatey.exe (goto installffmpeg)
echo.
echo Installing Chocolatey.. (to then install FFmpeg)
echo.
powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
:installffmpeg
call %ProgramData%\Chocolatey\bin\RefreshEnv.cmd
echo Installing FFmpeg..
echo.
choco install ffmpeg -y -force
:Resolution
set inputvideo=%*
ffprobe -v error -select_streams v:0 -show_entries stream=width -i %inputvideo% -of csv=p=0 > %temp%\width.txt
ffprobe -v error -select_streams v:0 -show_entries stream=height -i %inputvideo% -of csv=p=0 > %temp%\height.txt
set /p height=<%temp%\height.txt
set /p width=<%temp%\width.txt
set fullres=%width%x%height%
set algotype=stretch
if '%fullres%'=='3840x2160' (cls) & (echo Video is already in 4K, exitting..) & (timeout 3 > nul) & (exit)
if '%height%'=='1080' (set algotype=stretch)
if '%height%'=='720' (set algotype=factor)&(set scalefactor=3)
if '%height%'=='540' (set algotype=factor)&(set scalefactor=4)

if /i %hwaccel% == cpu (goto :check)
if /i %hwaccel% == intel (goto :check)
goto EncoderOptions
:check
if /i %enablecpuwarning% == yes (goto cpuwarning) else (goto EncoderOptions)
:CPUwarning
cls
echo Warning: this script is using your CPU/integrated graphics to upscale your video.
echo.
echo Detected: %gpu_name%
echo If your PC's a laptop with an NVIDIA card, edit the ForceEncoder variable in the batchfile to your PC's GPU
echo.
echo If this is intended, you can disable this warning by setting EnableCPUWarning to no.
CHOICE /N /C OC /M "Press O to open the batchfile, press C to continue
if '%ERRORLEVEL%'=='1' (
if exist "%programfiles(x86)%\Notepad++\notepad++.exe" ("%programfiles(x86)%\Notepad++\notepad++.exe" %~f0) & exit
if exist "%programfiles%\Notepad++\notepad++.exe" ("%programfiles(x86)%\Notepad++\notepad++.exe" %~f0) & exit
if exist "%programfiles%\Microsoft VS Code\Code.exe" ("%programfiles%\Microsoft VS Code\Code.exe" %~f0) & exit
start notepad %~f0 & exit
)
if '%ERRORLEVEL%'=='2' (cls)
:EncoderOptions
if /I %forcedencoderopts% == no (
    :: Choosing encoder
    if /I %hwaccel% == cpu (
        if /I %codec% == AVC (
            set encoderopts=-c:v libx264
            set encpreset=%cpupreset%
            set qualityarg=-crf
            set quality=15
        )
        if /I %codec% == HEVC (
            set encoderopts=-c:v libx265
            set encpreset=%cpupreset%
            set qualityarg=-crf
            set quality=18
        )
    )
    if /I %hwaccel% == NVENC (
        set hwaccelarg=-hwaccel cuda -threads 8
        if /I %codec% == AVC (
            set encoderopts=-c:v h264_nvenc -rc constqp
            set encpreset=p7
            set qualityarg=-qp
            set quality=15
        )
        if /I %codec% == HEVC (
            set encoderopts=-c:v hevc_nvenc -rc constqp
            set encpreset=p7
            set qualityarg=-qp
            set quality=18
        )
    )
    if /I %hwaccel% == AMD (
        set hwaccelarg=-hwaccel d3d11va
        if /I %codec% == AVC (
            set encoderopts=-c:v h264_amf
            set encpreset=quality
            set quality=12
            set amd=yes
        )
        if /I %codec% == HEVC (
            set encoderopts=-c:v hevc_amf
            set encpreset=quality
            set quality=16
            set amd=yes
        )
    )
    if /I %hwaccel% == Intel (
        set hwaccelarg=-hwaccel d3d11va
        if /I %codec% == AVC (
            set encoderopts=-c:v h264_qsv
            set encpreset=veryslow
            set qualityarg=-global_quality:v
            set quality=15
        )
        if /I %codec% == HEVC (
            set encoderopts=-c:v hevc_qsv
            set encpreset=veryslow
            set qualityarg=-global_quality:v
            set quality=18
        )
    )
    :: Fuck you batch
    set recreatecommand=yes
) else (
    :: Ability to force encoder options
    set encoderarg=%forcedencoderopts%
    set recreatecommand=no
)
if /I NOT %forcepreset% == no (
    set encpreset=%forcepreset%
)
if /I %recreatecommand% == yes (
    if /I %amd%1 == yes1 (
        set encoderarg=%encoderopts% -qp_i %quality% -qp_p %quality% -qp_b %quality% %globaloptions% -quality %encpreset%
    ) else (
        set encoderarg=%encoderopts% %qualityarg% %quality% %globaloptions% %presetcommand% %encpreset%
    )
)

::stretchalgo
if /I %algotype%==factor set filter=-vf %factoralgo%=%scalefactor%
if /I %algotype%==stretch set filter=-vf scale=-2:%targetresolution%:flags=%stretchalgo%

:execution
echo Input file: %1
echo Input resolution: %fullres%
echo Video filters: %filter%
echo Encode: %hwaccel% using %codec% codec
echo Encoding arguments: %encoderarg%
::If you're having trouble with this script, you can remove the :: from the next line to see the FFmpeg command it tries to create.
%ShowCommand%echo ffmpeg -loglevel warning -stats %hwaccelarg% -i %1 %filter% %encoderarg% -c:a copy -vsync vfr "%~dpn1-Upscaled.%container%"
ffmpeg -loglevel warning -stats %hwaccelarg% -i %1 %filter% %encoderarg% -c:a copy -vsync vfr "%~dpn1-Upscaled.%container%"
if '%ERRORLEVEL%'=='0' (goto success) else (goto fail)


:success
powershell Write-Host Upscale Done -BackgroundColor DarkGreen
if exist "%chocolateyinstall%\bin\ffprobe.exe" (ffplay "C:\Windows\Media\ding.wav" -volume 20 -autoexit -showmode 0 -loglevel quiet)
if exist "%temp%\height.txt" (del "%temp%\height.txt")
if exist "%temp%\width.txt" (del "%temp%\width.txt")
timeout 3 > nul & exit

:fail
if exist "%temp%\height.txt" (del "%temp%\height.txt")
if exist "%temp%\width.txt" (del "%temp%\width.txt")
echo.
echo The FFmpeg command did not work, here's a few things you can do to troubleshoot before coming asking for support in CTT:
echo.
echo - First time user of this script and it says "no input file"? Relaunch the script by pressing R
echo.
echo - If you're using an old encoder, press E to open the script with notepad and try replacing codec=HEVC by codec=AVC
echo.
echo - Double check you're running on FFmpeg 4.4 by pressing T
echo.
CHOICE /C RET /N
cls
if '%ERRORLEVEL%'=='1' (goto start)
if '%ERRORLEVEL%'=='2' (
if exist "%programfiles(x86)%\Notepad++\notepad++.exe" ("%programfiles(x86)%\Notepad++\notepad++.exe" %~f0 ) & exit
if exist "%programfiles%\Notepad++\notepad++.exe" ("%programfiles(x86)%\Notepad++\notepad++.exe" %~f0 ) & exit
if exist "%programfiles%\Microsoft VS Code\Code.exe" ("%programfiles%\Microsoft VS Code\Code.exe" %~f0 ) & exit
start notepad %~f0 & exit
)
if '%ERRORLEVEL%'=='3' (ffmpeg -version) & (pause)
