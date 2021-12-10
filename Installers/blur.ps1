Write-Warning "blurconf1 is deprecated, you can use blur.exe while you wait for AIO-Video"
timeout.exe 4 | Out-Null
start https://github.com/f0e/blur/releases/latest/download/blur-installer.exe
exit

#region installation
$host.ui.RawUI.WindowTitle = "blurconf1 installer -coul"
$WR = "$env:LOCALAPPDATA\Microsoft\WindowsApps"
$ST = "$env:appdata\Microsoft\Windows\SendTo"
$PF86 = "${env:ProgramFiles(x86)}"
$TMP = "$env:TEMP"
function DownloadFile{
    $webClient = [System.Net.WebClient]::new()
    $webClient.DownloadFile($source, $destination)
}
function DeleteIfExist ($Item) {
    if (Test-Path $Item){Remove-Item $Item -Recurse -Force -ErrorAction SilentlyContinue}
}
function InstallBlur {

        $Size = (Invoke-WebRequest -Useb "https://github.com/f0e/blur/releases/latest/download/blur-installer.exe" -Method Head).Headers.'Content-Length'
        $Size = [math]::Round($Size/1MB,2)
        Write-Output "Downloading blur-installer.. [$($Size)MB]"

        $exe = "$env:TMP\blur-installer.exe"
        $null = curl.exe -# -L -o $exe https://github.com/f0e/blur/releases/latest/download/blur-installer.exe
        Write-Output "Running blur-installer"
        Start-Process $exe -Verb RunAs -ArgumentList "/SILENT /ALLUSERS /NORESTART" -Wait

    if (!(Test-Path "$PF86\blur\lib\vapoursynth\PIL\msvcp140.dll")){

        $exe = "$env:TMP\vc_redist.x86.exe"
        $Size = (Invoke-WebRequest -Useb "https://aka.ms/vs/16/release/vc_redist.x86.exe" -Method Head).Headers.'Content-Length'
        $Size = [math]::Round($Size/1MB,2)
        Write-Output "Dowloading  Visual C++ runtimes [$($Size)MB]"

        $null = curl.exe -# -L -o $exe 'https://aka.ms/vs/16/release/vc_redist.x86.exe'
        Write-Output "Installing Visual C++ runtimes"
        Start-Process $exe -Verb RunAs -ArgumentList "/PASSIVE /ALLUSERS /NORESTART" -Wait}

}
#endregion
#region shortcuts and checks

"Do you wish to associate .cfg with Notepad? [Y/N]"
choice /N
if ($LASTEXITCODE -eq 1){start-process cmd -verb runas -argumentlist "cmd /c assoc .cfg=txtfile" -Wait}

Write-Output "Making a shortcut in WindowsApps folder (Windows+R).."
Start-Sleep 1
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$WR\blur.lnk")
$Shortcut.TargetPath = "$PF86\blur\blur.exe"
$Shortcut.Save()

Write-Output "Making a shortcut to the WindowsApps folder.."
Start-Sleep 1
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$WR\WR.lnk")
$Shortcut.TargetPath = "$WR"
$Shortcut.Save()
Remove-Item "$WR\CTT.lnk" -Force -ErrorAction SilentlyContinue
if (-not(test-path "$env:ProgramData\CTT")){mkdir "$env:ProgramData\CTT" | Out-Null}
Write-Output "Making a shortcut to ProgramData\CTT.."
Start-Sleep 1
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$WR\CTT.lnk")
$Shortcut.TargetPath = "$env:homedrive\ProgramData\CTT"
$Shortcut.Save()

Write-Output "Making a shortcut to the Sendto folder.."
Start-Sleep 1
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$WR\ST.lnk")
$Shortcut.TargetPath = "$env:appdata\Microsoft\Windows\SendTo"
$Shortcut.Save()
#endregion
#region blurconf1 check
if (-not(Test-Path "$env:ProgramData\CTT\blurconf1")){mkdir "$env:ProgramData\CTT\blurconf1" | Out-Null}else{

Write-Host "blurconf already installed, press C to continue and overwrite installation or E to exit"
choice /C CE /N
if ($LASTEXITCODE -eq 1){
    Remove-Item "$env:ProgramData\CTT\blurconf1" -Recurse -Force -ErrorAction SilentlyContinue
    mkdir "$env:ProgramData\CTT\blurconf1" | Out-Null
    }
if ($LASTEXITCODE -eq 2){exit}
}
$bc1 = "$env:ProgramData\CTT\blurconf1"
#endregion blurconf1 check
#region replace.vbs
@'
Const ForReading = 1
Const ForWriting = 2

strFileName = Wscript.Arguments(0)
strOldText = Wscript.Arguments(1)
strNewText = Wscript.Arguments(2)

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.OpenTextFile(strFileName, ForReading)

strText = objFile.ReadAll
objFile.Close
strNewText = Replace(strText, strOldText, strNewText)

Set objFile = objFSO.OpenTextFile(strFileName, ForWriting)
objFile.Write strNewText
objFile.Close
'@ | Set-Content "$bc1\replace.vbs"
#endregion replace.vbs
#region .bat
@'
@echo off
mode con cols=78 lines=23
title tekno's blur ^| edited for sendto ^& static conf -coul
set c="%ProgramData%\CTT\blurconf1\blurconf-static.cfg"
set r="%ProgramData%\CTT\blurconf1\replace.vbs"
set b="%ProgramFiles(x86)%\blur\blur.exe"
::IF [%1]==[] (%b%)
:main
cls
echo.
echo                          _/        _/
echo                         _/_/_/    _/  _/    _/  _/  _/_/
echo                        _/    _/  _/  _/    _/  _/_/
echo                       _/    _/  _/  _/    _/  _/
echo                      _/_/_/    _/    _/_/_/  _/
echo.
echo  ---------------------------------------------------------------------------
echo.
echo                                   [b]lur
echo                                [i]nterpolate
echo                         interpolate [a]nd blur (both)
echo                          [e]dit blurconf-static.cfg
echo.
echo Type one of the letters in [b]rackets to get started, type O for more options
choice /C BIAEO /N
echo %errorlevel%
pause
cd "%ProgramData%\CTT\blurconf1"
if '%errorlevel%'=='1' (goto blur)
if '%errorlevel%'=='2' (goto interpolate)
if '%errorlevel%'=='3' (goto and)
if '%errorlevel%'=='4' (notepad %c% & cls & goto main)
if '%errorlevel%'=='5' (goto options)
:blur
cscript //Nologo ".\replace.vbs" "blurconf-static.cfg" "blur: false" "blur: true"> nul
cscript //Nologo ".\replace.vbs" "blurconf-static.cfg" "blur:false" "blur:true"> nul
cscript //Nologo ".\replace.vbs" "blurconf-static.cfg" "interpolate: true" "interpolate: false"> nul
cscript //Nologo ".\replace.vbs" "blurconf-static.cfg" "interpolate:true" "interpolate:false"> nul
goto execution
:interpolate
cscript //Nologo ".\replace.vbs" "blurconf-static.cfg" "blur: true" "blur: false"> nul
cscript //Nologo ".\replace.vbs" "blurconf-static.cfg" "blur:true" "blur:false"> nul
cscript //Nologo ".\replace.vbs" "blurconf-static.cfg" "interpolate: false" "interpolate: true"> nul
cscript //Nologo ".\replace.vbs" "blurconf-static.cfg" "interpolate:false" "interpolate:true"> nul
goto execution
:and
cscript //Nologo ".\replace.vbs" "blurconf-static.cfg" "blur: false" "blur: true"> nul
cscript //Nologo ".\replace.vbs" "blurconf-static.cfg" "blur:false" "blur:true"> nul
cscript //Nologo ".\replace.vbs" "blurconf-static.cfg" "interpolate: false" "interpolate: true"> nul
cscript //Nologo ".\replace.vbs" "blurconf-static.cfg" "interpolate:false" "interpolate:true"> nul
goto execution
:execution
set input=-i %1 -c %c%
IF NOT [%2]==[] (set input=%input% -i %2 -c %c% & set VideoCount=2)
IF NOT [%3]==[] (set input=%input% -i %3 -c %c% & set VideoCount=3)
IF NOT [%4]==[] (set input=%input% -i %4 -c %c% & set VideoCount=4)
IF NOT [%5]==[] (set input=%input% -i %5 -c %c% & set VideoCount=5)
IF NOT [%6]==[] (set input=%input% -i %6 -c %c% & set VideoCount=6)
IF NOT [%7]==[] (set input=%input% -i %7 -c %c% & set VideoCount=7)
IF NOT [%8]==[] (set input=%input% -i %8 -c %c% & set VideoCount=8)
IF NOT [%9]==[] (set input=%input% -i %9 -c %c% & set VideoCount=9)
mode con cols=100
IF NOT [%VideoCount%]==[] (echo Queued %VideoCount% videos..)
%b% %input% -n
powershell Write-Host Upscale Done -BackgroundColor DarkGreen
if exist "%chocolateyinstall%\bin\ffprobe.exe" (ffplay "C:\Windows\Media\ding.wav" -volume 20 -autoexit -showmode 0 -loglevel quiet)
timeout 3 > nul & exit /b
exit
:options
cls
echo.
echo                          _/        _/
echo                         _/_/_/    _/  _/    _/  _/  _/_/
echo                        _/    _/  _/  _/    _/  _/_/
echo                       _/    _/  _/  _/    _/  _/
echo                      _/_/_/    _/    _/_/_/  _/
echo.
echo  ---------------------------------------------------------------------------
echo.
echo                           Open blur's [d]irectory
echo                       Open blur's [G]itHub repository
echo.
echo                           Go back to [m]ain menu
choice /C DGM /N
::if '%errorlevel%'=='1' (explorer "%ProgramFiles(x86)%\blur" & goto options)
if '%errorlevel%'=='2' (explorer "https://github.com/f0e/blur" & goto options)
if '%errorlevel%'=='3' (goto main)
:EOF
'@ | Set-Content "$env:appdata\Microsoft\Windows\SendTo\blurconf.bat"
#endregion .bat
#region .cfg
#clear-host
$Detection = (Get-WmiObject Win32_VideoController).AdapterCompatibility
$Detection2 = (Get-WmiObject Win32_VideoController).Caption
Write-Output "Select an encoder:

Detected: $detection2 ($Detection)

Press N for NVENC (NVIDIA)
Press Q for QuickSync (Intel iGPUs)
Press A for AMD (AMF)
Press C for CPU"
choice /C NQAC /N
if ($LASTEXITCODE -eq '1'){$GPU = "nvidia";$GPUToggle = "true"}
if ($LASTEXITCODE -eq '2'){$GPU = "intel";$GPUToggle = "true"}
if ($LASTEXITCODE -eq '3'){$GPU = "amd";$GPUToggle = "true"}
if ($LASTEXITCODE -eq '4'){$GPU = "";$GPUToggle = "false"}

@"
- blur
blur: true
blur amount: 1
blur output fps: 60
blur weighting: equal

- interpolation
interpolate: false
interpolated fps: 960
interpolation program (svp/rife/rife-ncnn): svp
interpolation speed: default
interpolation tuning: smooth
interpolation algorithm: 2

- rendering
quality: 17
preview: false
detailed filenames: false

- advanced rendering
multithreading: true
gpu: $gputoggle
gpu type (nvidia/amd/intel): $gpu
custom ffmpeg filters (overrides quality & gpu):

- advanced blur
blur weighting gaussian std dev: 2
blur weighting triangle reverse: false
blur weighting bound: [0,2]

- rendering filters
brightness: 1
saturation: 1
contrast: 1

- timescale
input timescale: 1
output timescale: 1
adjust timescaled audio pitch: false
"@ | Set-Content "$env:ProgramData\CTT\blurconf1\blurconf-static.cfg"
#endregion .cfg
#region final
#clear-host

if (Test-Path "$PF86\blur\blur.exe"){
    Write-Output "blur is already installed, which actions would you like to take?

    Press R to delete and reinstall
    Press S to skip blur installation
    Press E to exit this installer"
    choice /C RSE /N

    if ($LASTEXITCODE -eq '1'){#Delete and reinstall
        Stop-Process -name blur -Force -ErrorAction SilentlyContinue
        Stop-Process -name "tekno's blur" -Force -ErrorAction SilentlyContinue
        InstallBlur
}
    if ($LASTEXITCODE -eq '2'){break}#Skip blur installation
    if ($LASTEXITCODE -eq '3'){exit}#Exit this installer

    }else{InstallBlur}

if ($GPU -eq 'nvidia'){
    Write-Output "Would you like to install RIFE? [Y/N]"

    choice /N
    if ($LASTEXITCODE -eq 1){
        Set-Location "${env:ProgramFiles(x86)}\blur\lib\vapoursynth" 
        $python = ".\python.exe"
        $pip = ".\scripts\pip.exe"
        $cmd = "install -t . torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio===0.9.0 -f https://download.pytorch.org/whl/torch_stable.html vsrife"
        $ex = "$python $pip $cmd"
        Invoke-Expression $ex
    }
    if ($GPU -eq 'amd'){
        "RIFE-NCNN is not currently available"
    }
}
Write-Output "Install done!

You can now select one or multiple videos and queue them to blur:

1. Select the videos you wish to queue
2. Right click -> Send To -> blurconf.bat
3. Press the letter that's in [b]rackets to select desired action
"
pause
exit
#endregion
