:::::::::::::::::::::::::::
::                       ::
:: Lunar Client Launcher ::
::                       ::
:::::::::::::::::::::::::::

:: LCL is a quicker way to launch LC and keep your OptiFine settings tidy when switching versions.

:: Credits:

:: Couleur for setting up the script and variables
:: Lemons for the javaw launch command itself  https://github.com/respecting
:: temp for the OptiFine settings and echo patch
:: Aetopia for the quick launch batch files

mode con: cols=100 lines=5

::Installation Settings
::NOTE: MAKE SURE TO NOT LEAVE A SPACE BEFORE "=" OR ELSE YOUR CONFIGURED SETTINGS WILL NOT WORK.
::Global JVM Arguments
set JVArguments=-Xms3072m -Xmx3072m
::This is the Java Arguments, leave them as is if you don't know what you're doing.
::Directory
set legacydir=%APPDATA%\.minecraft
set moderndir=%APPDATA%\.minecraft
::Set the Installation Directories here, legacydir for versions 1.7-1.8 and moderndir for versions 1.12-1.17

::If you want settings per version then scroll down to them and replace the variables
@echo off
title Lunar Launcher (No Patcher) - set up by couleur, launch by lemons and settings by temp

:Checking if LunarClient is installed
if exist "%appdata%\.minecraft" goto :choose else goto :installLC
if exist "%LOCALAPPDATA%\Programs\.lunarclient\Lunar Client.exe" goto :choose else goto :installLC

:installLC
echo Minecraft/LunarClient not found, press a key to automatically go to the download page 
echo and close this window.
pause >nul
start https://www.lunarclient.com/download/
exit

:choose
xcopy %appdata%\.minecraft\assets\indexes %legacydir%\assets\indexes /E/H/C/I/Y/F
xcopy %appdata%\.minecraft\assets\indexes %moderndir%\assets\indexes /E/H/C/I/Y/F
cls
color F
set /p version="> Launch Lunar Client version 1."
if '%version%'=='7' set version=7.10
if '%version%'=='7.10' goto :1.7

if '%version%'=='8' set version=8.9
if '%version%'=='8.9' goto :1.8

if '%version%'=='12' set version=1.12
if '%version%'=='1.12' goto :1.12

if '%version%'=='16' set version=1.16
if '%version%'=='1.16' goto :1.16

if '%version%'=='17' set version=1.17
if '%version%'=='1.17' goto :1.17

echo '%version%' is incorrect, either pick '7' for 1.7.10, '8' for 1.8.9,
echo '12' for 1.12, '16' for 1.16, '17' for 1.17.
pause >nul
goto :choose

:1.7
set versionfull=1.7.10
if exist "%USERPROFILE%\.lunarclient\offline\1.7" (echo.) else goto :noversion
set version=1.7
goto :launchlegacy

:1.8
set versionfull=1.8.9
if exist "%USERPROFILE%\.lunarclient\offline\1.8" (echo.) else goto :noversion
set version=1.8
goto :launchlegacy

:1.16
set versionfull=1.16.5
if exist "%USERPROFILE%\.lunarclient\offline\1.16" (echo.) else goto :noversion
set version=1.16
goto :launchmodern

:1.17
set versionfull=1.17
if exist "%USERPROFILE%\.lunarclient\offline\1.17" (echo.) else goto :noversion
set version=1.17
if '%TweakOptiFineSettings%=='false' (goto :launchmodern) else (goto :newof)

:1.12
set versionfull=1.12
if exist "%USERPROFILE%\.lunarclient\offline\1.12" (echo.) else goto :noversion
set version=1.12
goto :launchmodern

:launchlegacy
for /D %%I in ("%USERPROFILE%\.lunarclient\jre\zulu*") do start "" %%~I\bin\javaw.exe --add-modules jdk.naming.dns --add-exports jdk.naming.dns/com.sun.jndi.dns=java.naming -Djna.boot.library.path=%USERPROFILE%\.lunarclient\offline\%version%\natives --add-opens java.base/java.io=ALL-UNNAMED %JVArguments% -Djava.library.path=%USERPROFILE%\.lunarclient\offline\%version%\natives -XX:+DisableAttachMechanism -cp %USERPROFILE%\.lunarclient\offline\%version%\lunar-assets-prod-1-optifine.jar;%USERPROFILE%\.lunarclient\offline\%version%\lunar-assets-prod-2-optifine.jar;%USERPROFILE%\.lunarclient\offline\%version%\lunar-assets-prod-3-optifine.jar;%USERPROFILE%\.lunarclient\offline\%version%\lunar-libs.jar;%USERPROFILE%\.lunarclient\offline\%version%\lunar-prod-optifine.jar;%USERPROFILE%\.lunarclient\offline\%version%\OptiFine.jar;%USERPROFILE%\.lunarclient\offline\%version%\vpatcher-prod.jar com.moonsworth.lunar.patcher.LunarMain --version %version% --accessToken 0 --assetIndex %version% --userProperties {} --gameDir %legacydir% --texturesDir %USERPROFILE%\.lunarclient\textures --width 854 --height 480 & exit

:launchmodern
for /D %%I in ("%USERPROFILE%\.lunarclient\jre\zulu*") do start "" %%~I\bin\javaw.exe --add-modules jdk.naming.dns --add-exports jdk.naming.dns/com.sun.jndi.dns=java.naming -Djna.boot.library.path=%USERPROFILE%\.lunarclient\offline\%version%\natives --add-opens java.base/java.io=ALL-UNNAMED %JVArguments% -Djava.library.path=%USERPROFILE%\.lunarclient\offline\%version%\natives -XX:+DisableAttachMechanism -cp %USERPROFILE%\.lunarclient\offline\%version%\lunar-assets-prod-1-optifine.jar;%USERPROFILE%\.lunarclient\offline\%version%\lunar-assets-prod-2-optifine.jar;%USERPROFILE%\.lunarclient\offline\%version%\lunar-assets-prod-3-optifine.jar;%USERPROFILE%\.lunarclient\offline\%version%\lunar-libs.jar;%USERPROFILE%\.lunarclient\offline\%version%\lunar-prod-optifine.jar;%USERPROFILE%\.lunarclient\offline\%version%\OptiFine.jar;%USERPROFILE%\.lunarclient\offline\%version%\vpatcher-prod.jar com.moonsworth.lunar.patcher.LunarMain --version %version% --accessToken 0 --assetIndex %version% --userProperties {} --gameDir %moderndir% --texturesDir %USERPROFILE%\.lunarclient\textures --width 854 --height 480 & exit

:noversion
CLS
echo %versionfull% not installed, launch it manually once before running again.
pause >nul
exit