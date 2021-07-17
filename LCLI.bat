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
set legacydir=C:\Users\User\Documents\Test
set moderndir=C:\Users\User\Documents\Test2
::Set the Installation Directories here, legacydir for versions 1.7-1.8 and moderndir for versions 1.12-1.17

:::::::::::::::::::::::::::::::::
::                             ::
:: PERMANENT OPTIFINE SETTINGS ::
::                             ::
:::::::::::::::::::::::::::::::::

:: REMINDER: setting an option to "true"  will enable it, false will disable it


set TweakOptiFineSettings=true
::If the setting above is set to false, no settings will be applied

set FullscreenMode=Default
::'Default' will scale Minecraft according to your current resolution
::If you want it to force a downscale (like 720p) then type in 1280x720
::The main downside is long tab-out times (3-5 seconds black screens)

set FastRender=true
::Setting FastRender false will decrease FPS but make lc motion-blur work

set SmoothFPS=false
::Setting Smooth FPS to true will decrease FPS but let more resources to OBS (e.g encoding lag)

set RenderDistance=6
set CustomSky=false

:: To set 'X' as the zoom key, it's stored as the number 45.
:: IF YOU WANT A 
set Zoom Key-old=45
set Zoom Key-new=x
:: In older versions, 45 = X for controls

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
if '%TweakOptiFineSettings%=='false' (goto :launch)
(echo ofRenderDistanceChunks:%RenderDistance%) > %legacydir%\optionsof.txt
(echo ofFogType:3) >> %legacydir%\optionsof.txt
(echo ofFogStart:0.8) >> %legacydir%\optionsof.txt
(echo ofMipmapType:3) >> %legacydir%\optionsof.txt
(echo ofLoadFar:false) >> %legacydir%\optionsof.txt
(echo ofPreloadedChunks:0) >> %legacydir%\optionsof.txt
(echo ofOcclusionFancy:false) >> %legacydir%\optionsof.txt
(echo ofSmoothFps:%SmoothFPS%) >> %legacydir%\optionsof.txt
(echo ofSmoothWorld:false) >> %legacydir%\optionsof.txt
(echo ofAoLevel:0.0) >> %legacydir%\optionsof.txt
(echo ofClouds:3) >> %legacydir%\optionsof.txt
(echo ofCloudsHeight:0.0) >> %legacydir%\optionsof.txt
(echo ofTrees:1) >> %legacydir%\optionsof.txt
(echo ofGrass:0) >> %legacydir%\optionsof.txt
(echo ofDroppedItems:1) >> %legacydir%\optionsof.txt
(echo ofRain:3) >> %legacydir%\optionsof.txt
(echo ofWater:0) >> %legacydir%\optionsof.txt
(echo ofAnimatedWater:0) >> %legacydir%\optionsof.txt
(echo ofAnimatedLava:0) >> %legacydir%\optionsof.txt
(echo ofAnimatedFire:true) >> %legacydir%\optionsof.txt
(echo ofAnimatedPortal:true) >> %legacydir%\optionsof.txt
(echo ofAnimatedRedstone:true) >> %legacydir%\optionsof.txt
(echo ofAnimatedExplosion:true) >> %legacydir%\optionsof.txt
(echo ofAnimatedFlame:true) >> %legacydir%\optionsof.txt
(echo ofAnimatedSmoke:true) >> %legacydir%\optionsof.txt
(echo ofVoidParticles:true) >> %legacydir%\optionsof.txt
(echo ofWaterParticles:true) >> %legacydir%\optionsof.txt
(echo ofPortalParticles:true) >> %legacydir%\optionsof.txt
(echo ofPotionParticles:true) >> %legacydir%\optionsof.txt
(echo ofDrippingWaterLava:true) >> %legacydir%\optionsof.txt
(echo ofAnimatedTerrain:true) >> %legacydir%\optionsof.txt
(echo ofAnimatedTextures:true) >> %legacydir%\optionsof.txt
(echo ofAnimatedItems:true) >> %legacydir%\optionsof.txt
(echo ofRainSplash:true) >> %legacydir%\optionsof.txt
(echo ofLagometer:false) >> %legacydir%\optionsof.txt
(echo ofShowFps:false) >> %legacydir%\optionsof.txt
(echo ofAutoSaveTicks:4000) >> %legacydir%\optionsof.txt
(echo ofBetterGrass:3) >> %legacydir%\optionsof.txt
(echo ofConnectedTextures:1) >> %legacydir%\optionsof.txt
(echo ofWeather:true) >> %legacydir%\optionsof.txt
(echo ofSky:false) >> %legacydir%\optionsof.txt
(echo ofStars:true) >> %legacydir%\optionsof.txt
(echo ofSunMoon:false) >> %legacydir%\optionsof.txt
(echo ofVignette:1) >> %legacydir%\optionsof.txt
(echo ofChunkUpdates:1) >> %legacydir%\optionsof.txt
(echo ofChunkLoading:0) >> %legacydir%\optionsof.txt
(echo ofChunkUpdatesDynamic:false) >> %legacydir%\optionsof.txt
(echo ofTime:1) >> %legacydir%\optionsof.txt
(echo ofClearWater:false) >> %legacydir%\optionsof.txt
(echo ofDepthFog:false) >> %legacydir%\optionsof.txt
(echo ofAaLevel:0) >> %legacydir%\optionsof.txt
(echo ofProfiler:false) >> %legacydir%\optionsof.txt
(echo ofBetterSnow:false) >> %legacydir%\optionsof.txt
(echo ofSwampColors:false) >> %legacydir%\optionsof.txt
(echo ofRandomMobs:false) >> %legacydir%\optionsof.txt
(echo ofSmoothBiomes:false) >> %legacydir%\optionsof.txt
(echo ofCustomFonts:false) >> %legacydir%\optionsof.txt
(echo ofCustomColors:false) >> %legacydir%\optionsof.txt
(echo ofCustomSky:%CustomSky%) >> %legacydir%\optionsof.txt
(echo ofShowCapes:true) >> %legacydir%\optionsof.txt
(echo ofNaturalTextures:false) >> %legacydir%\optionsof.txt
(echo ofLazyChunkLoading:false) >> %legacydir%\optionsof.txt
(echo ofDynamicFov:true) >> %legacydir%\optionsof.txt
(echo ofDynamicLights:3) >> %legacydir%\optionsof.txt
(echo ofFullscreenMode:%FullscreenMode%) >> %legacydir%\optionsof.txt
(echo ofFastMath:true) >> %legacydir%\optionsof.txt
(echo ofFastRender:%FastRender%) >> %legacydir%\optionsof.txt
(echo ofTranslucentBlocks:1) >> %legacydir%\optionsof.txt
goto :launchlegacy

:1.8
set versionfull=1.8.9
if exist "%USERPROFILE%\.lunarclient\offline\1.8" (echo.) else goto :noversion
set version=1.8
if '%TweakOptiFineSettings%=='false' (goto :launch)
(echo ofFogType:3) > %legacydir%\optionsof.txt
(echo ofFogStart:0.6) >> %legacydir%\optionsof.txt
(echo ofMipmapType:3) >> %legacydir%\optionsof.txt
(echo ofOcclusionFancy:false) >> %legacydir%\optionsof.txt
(echo ofSmoothFps:%SmoothFPS%) >> %legacydir%\optionsof.txt
(echo ofSmoothWorld:false) >> %legacydir%\optionsof.txt
(echo ofAoLevel:0.0) >> %legacydir%\optionsof.txt
(echo ofClouds:3) >> %legacydir%\optionsof.txt
(echo ofCloudsHeight:0.0) >> %legacydir%\optionsof.txt
(echo ofTrees:1) >> %legacydir%\optionsof.txt
(echo ofDroppedItems:1) >> %legacydir%\optionsof.txt
(echo ofRain:3) >> %legacydir%\optionsof.txt
(echo ofAnimatedWater:0) >> %legacydir%\optionsof.txt
(echo ofAnimatedLava:0) >> %legacydir%\optionsof.txt
(echo ofAnimatedFire:true) >> %legacydir%\optionsof.txt
(echo ofAnimatedPortal:true) >> %legacydir%\optionsof.txt
(echo ofAnimatedRedstone:true) >> %legacydir%\optionsof.txt
(echo ofAnimatedExplosion:true) >> %legacydir%\optionsof.txt
(echo ofAnimatedFlame:true) >> %legacydir%\optionsof.txt
(echo ofAnimatedSmoke:true) >> %legacydir%\optionsof.txt
(echo ofVoidParticles:true) >> %legacydir%\optionsof.txt
(echo ofWaterParticles:true) >> %legacydir%\optionsof.txt
(echo ofPortalParticles:true) >> %legacydir%\optionsof.txt
(echo ofPotionParticles:true) >> %legacydir%\optionsof.txt
(echo ofFireworkParticles:true) >> %legacydir%\optionsof.txt
(echo ofDrippingWaterLava:true) >> %legacydir%\optionsof.txt
(echo ofAnimatedTerrain:true) >> %legacydir%\optionsof.txt
(echo ofAnimatedTextures:true) >> %legacydir%\optionsof.txt
(echo ofRainSplash:true) >> %legacydir%\optionsof.txt
(echo ofLagometer:false) >> %legacydir%\optionsof.txt
(echo ofShowFps:false) >> %legacydir%\optionsof.txt
(echo ofAutoSaveTicks:4000) >> %legacydir%\optionsof.txt
(echo ofBetterGrass:3) >> %legacydir%\optionsof.txt
(echo ofConnectedTextures:1) >> %legacydir%\optionsof.txt
(echo ofWeather:true) >> %legacydir%\optionsof.txt
(echo ofSky:false) >> %legacydir%\optionsof.txt
(echo ofStars:true) >> %legacydir%\optionsof.txt
(echo ofSunMoon:false) >> %legacydir%\optionsof.txt
(echo ofVignette:1) >> %legacydir%\optionsof.txt
(echo ofChunkUpdates:1) >> %legacydir%\optionsof.txt
(echo ofChunkUpdatesDynamic:false) >> %legacydir%\optionsof.txt
(echo ofTime:1) >> %legacydir%\optionsof.txt
(echo ofClearWater:false) >> %legacydir%\optionsof.txt
(echo ofAaLevel:0) >> %legacydir%\optionsof.txt
(echo ofAfLevel:1) >> %legacydir%\optionsof.txt
(echo ofProfiler:false) >> %legacydir%\optionsof.txt
(echo ofBetterSnow:false) >> %legacydir%\optionsof.txt
(echo ofSwampColors:false) >> %legacydir%\optionsof.txt
(echo ofRandomEntities:false) >> %legacydir%\optionsof.txt
(echo ofSmoothBiomes:false) >> %legacydir%\optionsof.txt
(echo ofCustomFonts:false) >> %legacydir%\optionsof.txt
(echo ofCustomColors:false) >> %legacydir%\optionsof.txt
(echo ofCustomItems:false) >> %legacydir%\optionsof.txt
(echo ofCustomSky:%CustomSky%) >> %legacydir%\optionsof.txt
(echo ofShowCapes:true) >> %legacydir%\optionsof.txt
(echo ofNaturalTextures:false) >> %legacydir%\optionsof.txt
(echo ofEmissiveTextures:false) >> %legacydir%\optionsof.txt
(echo ofLazyChunkLoading:false) >> %legacydir%\optionsof.txt
(echo ofRenderRegions:true) >> %legacydir%\optionsof.txt
(echo ofSmartAnimations:false) >> %legacydir%\optionsof.txt
(echo ofDynamicFov:true) >> %legacydir%\optionsof.txt
(echo ofAlternateBlocks:true) >> %legacydir%\optionsof.txt
(echo ofDynamicLights:3) >> %legacydir%\optionsof.txt
(echo ofScreenshotSize:1) >> %legacydir%\optionsof.txt
(echo ofCustomEntityModels:false) >> %legacydir%\optionsof.txt
(echo ofCustomGuis:false) >> %legacydir%\optionsof.txt
(echo ofShowGlErrors:true) >> %legacydir%\optionsof.txt
(echo ofFullscreenMode:%FullscreenMode%) >> %legacydir%\optionsof.txt
(echo ofFastMath:true) >> %legacydir%\optionsof.txt
(echo ofFastRender:%FastRender%) >> %legacydir%\optionsof.txt
(echo ofTranslucentBlocks:1) >> %legacydir%\optionsof.txt
(echo key_of.key.zoom:%Zoom Key-old%) >> %legacydir%\optionsof.txt
echo Hello >> %legacydir%
goto :launchlegacy

:1.16
set versionfull=1.16.5
if exist "%USERPROFILE%\.lunarclient\offline\1.16" (echo.) else goto :noversion
set version=1.16
if '%TweakOptiFineSettings%=='false' (goto :launchmodern) else (goto :newof)
goto :launchmodern

:1.17
set versionfull=1.17
if exist "%USERPROFILE%\.lunarclient\offline\1.17" (echo.) else goto :noversion
set version=1.17
if '%TweakOptiFineSettings%=='false' (goto :launchmodern) else (goto :newof)
goto :launchmodern 

:1.12
set versionfull=1.12
if exist "%USERPROFILE%\.lunarclient\offline\1.12" (echo.) else goto :noversion
set version=1.12
if '%TweakOptiFineSettings%=='false' (goto :launchmodern) else (goto :newof)
:newof
(echo ofFogType:3) > %moderndir%\optionsof.txt
(echo ofFogStart:0.6) >> %moderndir%\optionsof.txt
(echo ofMipmapType:3) >> %moderndir%\optionsof.txt
(echo ofOcclusionFancy:false) >> %moderndir%\optionsof.txt
(echo ofSmoothFps:%SmoothFPS%) >> %moderndir%\optionsof.txt
(echo ofSmoothWorld:false) >> %moderndir%\optionsof.txt
(echo ofAoLevel:0.0) >> %moderndir%\optionsof.txt
(echo ofClouds:3) >> %moderndir%\optionsof.txt
(echo ofCloudsHeight:0.0) >> %moderndir%\optionsof.txt
(echo ofTrees:1) >> %moderndir%\optionsof.txt
(echo ofDroppedItems:1) >> %moderndir%\optionsof.txt
(echo ofRain:3) >> %moderndir%\optionsof.txt
(echo ofAnimatedWater:0) >> %moderndir%\optionsof.txt
(echo ofAnimatedLava:0) >> %moderndir%\optionsof.txt
(echo ofAnimatedFire:true) >> %moderndir%\optionsof.txt
(echo ofAnimatedPortal:true) >> %moderndir%\optionsof.txt
(echo ofAnimatedRedstone:true) >> %moderndir%\optionsof.txt
(echo ofAnimatedExplosion:true) >> %moderndir%\optionsof.txt
(echo ofAnimatedFlame:true) >> %moderndir%\optionsof.txt
(echo ofAnimatedSmoke:true) >> %moderndir%\optionsof.txt
(echo ofVoidParticles:true) >> %moderndir%\optionsof.txt
(echo ofWaterParticles:true) >> %moderndir%\optionsof.txt
(echo ofPortalParticles:true) >> %moderndir%\optionsof.txt
(echo ofPotionParticles:true) >> %moderndir%\optionsof.txt
(echo ofFireworkParticles:true) >> %moderndir%\optionsof.txt
(echo ofDrippingWaterLava:true) >> %moderndir%\optionsof.txt
(echo ofAnimatedTerrain:true) >> %moderndir%\optionsof.txt
(echo ofAnimatedTextures:true) >> %moderndir%\optionsof.txt
(echo ofRainSplash:true) >> %moderndir%\optionsof.txt
(echo ofLagometer:false) >> %moderndir%\optionsof.txt
(echo ofShowFps:false) >> %moderndir%\optionsof.txt
(echo ofAutoSaveTicks:4000) >> %moderndir%\optionsof.txt
(echo ofBetterGrass:3) >> %moderndir%\optionsof.txt
(echo ofConnectedTextures:1) >> %moderndir%\optionsof.txt
(echo ofWeather:true) >> %moderndir%\optionsof.txt
(echo ofSky:false) >> %moderndir%\optionsof.txt
(echo ofStars:true) >> %moderndir%\optionsof.txt
(echo ofSunMoon:false) >> %moderndir%\optionsof.txt
(echo ofVignette:1) >> %moderndir%\optionsof.txt
(echo ofChunkUpdates:1) >> %moderndir%\optionsof.txt
(echo ofChunkUpdatesDynamic:false) >> %moderndir%\optionsof.txt
(echo ofTime:1) >> %moderndir%\optionsof.txt
(echo ofAaLevel:0) >> %moderndir%\optionsof.txt
(echo ofAfLevel:1) >> %moderndir%\optionsof.txt
(echo ofProfiler:false) >> %moderndir%\optionsof.txt
(echo ofBetterSnow:false) >> %moderndir%\optionsof.txt
(echo ofSwampColors:false) >> %moderndir%\optionsof.txt
(echo ofRandomEntities:false) >> %moderndir%\optionsof.txt
(echo ofCustomFonts:false) >> %moderndir%\optionsof.txt
(echo ofCustomColors:false) >> %moderndir%\optionsof.txt
(echo ofCustomItems:false) >> %moderndir%\optionsof.txt
(echo ofCustomSky:%CustomSky%) >> %moderndir%\optionsof.txt
(echo ofShowCapes:true) >> %moderndir%\optionsof.txt
(echo ofNaturalTextures:false) >> %moderndir%\optionsof.txt
(echo ofEmissiveTextures:true) >> %moderndir%\optionsof.txt
(echo ofLazyChunkLoading:true) >> %moderndir%\optionsof.txt
(echo ofRenderRegions:true) >> %moderndir%\optionsof.txt
(echo ofSmartAnimations:false) >> %moderndir%\optionsof.txt
(echo ofDynamicFov:true) >> %moderndir%\optionsof.txt
(echo ofAlternateBlocks:false) >> %moderndir%\optionsof.txt
(echo ofDynamicLights:3) >> %moderndir%\optionsof.txt
(echo ofScreenshotSize:1) >> %moderndir%\optionsof.txt
(echo ofCustomEntityModels:false) >> %moderndir%\optionsof.txt
(echo ofCustomGuis:false) >> %moderndir%\optionsof.txt
(echo ofShowGlErrors:true) >> %moderndir%\optionsof.txt
(echo ofFastMath:true) >> %moderndir%\optionsof.txt
(echo ofFastRender:%FastRender%) >> %moderndir%\optionsof.txt
(echo ofTranslucentBlocks:1) >> %moderndir%\optionsof.txt
(echo ofChatBackground:0) >> %moderndir%\optionsof.txt
(echo ofChatShadow:true) >> %moderndir%\optionsof.txt
(echo key_of.key.zoom:key.keyboard.left.control) >> %moderndir%\optionsof.txt
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