#region synopsis
# 1. Script sets everything up, sets safeboot then restarts
# 2. In Safe mode: launch DDU script by typing "ddu" in Windows+R
# 3. DDU launches, when you're done, DDU scripts removes safe mode and restarts your pc
# 2. After the restart: launch DDU script by typing "nvslimmer" in Windows+R
#endregion
#region dependencies

$wr = '' + $env:localappdata + '\Microsoft\WindowsApps'
del $wr\ddu.cmd
del $wr\nvslimmer.cmd

#ddu
$dduver = '18.0.4.2'
$ddulink = 'https://www.wagnardsoft.com/DDU/download/DDU%20v' + $dduver + '.exe'
Invoke-WebRequest $ddulink -OutFile $env:TEMP\DDU.exe
Start-Process $env:TEMP\DDU.exe -ArgumentList '-y' -Wait #s/o chalice le bg
Rename-Item "$env:TEMP\DDU v${dduver}\" "DDU"

#nvs
$nvslink = 'https://ftp.nluug.nl/pub/games/PC/guru3d/nvslimmer/[Guru3D.com]-NVSlimmer.zip'
Invoke-WebRequest $nvslink -OutFile $env:TEMP\NVSlimmer.zip
mkdir $env:temp\NVSlimmer
Expand-Archive $env:TEMP\NVSlimmer.zip $env:temp\NVSlimmer
#endregion

$dducmd =@'
@echo off
title DDU (Only close DDU when you are done!)
:startddu
start "Display Driver Uninstaller" /wait "%temp%\DDU\Display Driver Uninstaller.exe"
:prompt1
echo Did you successfully uninstall your driver? [Y/N]
echo.
set /p answer=>
if /i 'answer'=='yes' set answer=y
if /i 'answer'=='y' goto :restart
if /i 'answer'=='no' set answer=n
if /i 'answer'=='n' goto:startddu
echo %answer% isn't a valid answer! Type Y or N
:restart
bcdedit /deletevalue {default} safeboot
shutdown.exe /r /t 00
'@ | Out-File $wr\ddu.cmd -Encoding utf8

$nvslimmercmd =@'
@echo off & title NVSlimmer
echo Download your nvidia drivers, then press any key to continue..
timeout 2 >nul
start https://www.nvidia.com/Download/Find.aspx
pause
start "NVSlimmer" /wait "%temp%\NVSlimmer\NVslimmer.exe"
:prompt
echo Do you wish to keep the DDU and NVSlimmer shortcuts? [Y/N]
echo.
set /p answer=>
if /i 'answer'=='yes' set answer=y
if /i 'answer'=='y' exit
if /i 'answer'=='no' set answer=n
if /i 'answer'=='n' goto:del
echo %answer% isn't a valid answer! Type Y or N
goto :prompt
:del
cd 
del %localappdata%\Microsoft\WindowsApps\ddu.cmd
del %localappdata%\Microsoft\WindowsApps\nvslimmer.cmd
exit
'@ | Out-File $wr\nvslimmer.cmd -Encoding utf8

bcdedit /set safemode network 
shutdown.exe /r /t 00