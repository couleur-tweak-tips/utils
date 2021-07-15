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
:: Aetopia for the quicklaunch batchfiles


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


set JVArguments=-Xms3072m -Xmx3072m
::This is the Java Arguments, leave them as is if you don't know what you're doing.

::If you want settings per version then scroll down to them and replace the variables
@echo off
cd %appdata%\.minecraft
mode con: cols=100 lines=5
title Lunar Launcher - set up by couleur, launch by lemons and settings by temp
if '%TweakOptiFineSettings%'=='false' goto :choose

:Checking if LunarClient is installed
if exist "%appdata%\.minecraft" goto :choose else goto :installLC
if exist "%LOCALAPPDATA%\Programs\.lunarclient\Lunar Client.exe" goto :choose else goto :installLC

:installLC
echo Minecraft/LunarClient not found, press a key to automatically go to the download page 
echo and to close this window.
pause >nul
start https://www.lunarclient.com/download/
exit

:choose
cls
color F
set /p version="> Launch and patch Lunar Client version 1."
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
set versionfull=1.7
if exist "%USERPROFILE%\.lunarclient\offline\1.7" (echo.) else goto :noversion
set version=1.7
if '%TweakOptiFineSettings%=='false' (goto :launch)
(echo ofRenderDistanceChunks:%RenderDistance%) > optionsof.txt
(echo ofFogType:3) >> optionsof.txt
(echo ofFogStart:0.8) >> optionsof.txt
(echo ofMipmapType:3) >> optionsof.txt
(echo ofLoadFar:false) >> optionsof.txt
(echo ofPreloadedChunks:0) >> optionsof.txt
(echo ofOcclusionFancy:false) >> optionsof.txt
(echo ofSmoothFps:%SmoothFPS%) >> optionsof.txt
(echo ofSmoothWorld:false) >> optionsof.txt
(echo ofAoLevel:0.0) >> optionsof.txt
(echo ofClouds:3) >> optionsof.txt
(echo ofCloudsHeight:0.0) >> optionsof.txt
(echo ofTrees:1) >> optionsof.txt
(echo ofGrass:0) >> optionsof.txt
(echo ofDroppedItems:1) >> optionsof.txt
(echo ofRain:3) >> optionsof.txt
(echo ofWater:0) >> optionsof.txt
(echo ofAnimatedWater:0) >> optionsof.txt
(echo ofAnimatedLava:0) >> optionsof.txt
(echo ofAnimatedFire:true) >> optionsof.txt
(echo ofAnimatedPortal:true) >> optionsof.txt
(echo ofAnimatedRedstone:true) >> optionsof.txt
(echo ofAnimatedExplosion:true) >> optionsof.txt
(echo ofAnimatedFlame:true) >> optionsof.txt
(echo ofAnimatedSmoke:true) >> optionsof.txt
(echo ofVoidParticles:true) >> optionsof.txt
(echo ofWaterParticles:true) >> optionsof.txt
(echo ofPortalParticles:true) >> optionsof.txt
(echo ofPotionParticles:true) >> optionsof.txt
(echo ofDrippingWaterLava:true) >> optionsof.txt
(echo ofAnimatedTerrain:true) >> optionsof.txt
(echo ofAnimatedTextures:true) >> optionsof.txt
(echo ofAnimatedItems:true) >> optionsof.txt
(echo ofRainSplash:true) >> optionsof.txt
(echo ofLagometer:false) >> optionsof.txt
(echo ofShowFps:false) >> optionsof.txt
(echo ofAutoSaveTicks:4000) >> optionsof.txt
(echo ofBetterGrass:3) >> optionsof.txt
(echo ofConnectedTextures:1) >> optionsof.txt
(echo ofWeather:true) >> optionsof.txt
(echo ofSky:false) >> optionsof.txt
(echo ofStars:true) >> optionsof.txt
(echo ofSunMoon:false) >> optionsof.txt
(echo ofVignette:1) >> optionsof.txt
(echo ofChunkUpdates:1) >> optionsof.txt
(echo ofChunkLoading:0) >> optionsof.txt
(echo ofChunkUpdatesDynamic:false) >> optionsof.txt
(echo ofTime:1) >> optionsof.txt
(echo ofClearWater:false) >> optionsof.txt
(echo ofDepthFog:false) >> optionsof.txt
(echo ofAaLevel:0) >> optionsof.txt
(echo ofProfiler:false) >> optionsof.txt
(echo ofBetterSnow:false) >> optionsof.txt
(echo ofSwampColors:false) >> optionsof.txt
(echo ofRandomMobs:false) >> optionsof.txt
(echo ofSmoothBiomes:false) >> optionsof.txt
(echo ofCustomFonts:false) >> optionsof.txt
(echo ofCustomColors:false) >> optionsof.txt
(echo ofCustomSky:%CustomSky%) >> optionsof.txt
(echo ofShowCapes:true) >> optionsof.txt
(echo ofNaturalTextures:false) >> optionsof.txt
(echo ofLazyChunkLoading:false) >> optionsof.txt
(echo ofDynamicFov:true) >> optionsof.txt
(echo ofDynamicLights:3) >> optionsof.txt
(echo ofFullscreenMode:%FullscreenMode%) >> optionsof.txt
(echo ofFastMath:true) >> optionsof.txt
(echo ofFastRender:%FastRender%) >> optionsof.txt
(echo ofTranslucentBlocks:1) >> optionsof.txt
goto :launch

:1.8
set versionfull=1.8
if exist "%USERPROFILE%\.lunarclient\offline\1.8" (echo.) else goto :noversion
set version=1.8
if '%TweakOptiFineSettings%=='false' (goto :launch)
(echo ofFogType:3) > optionsof.txt
(echo ofFogStart:0.6) >> optionsof.txt
(echo ofMipmapType:3) >> optionsof.txt
(echo ofOcclusionFancy:false) >> optionsof.txt
(echo ofSmoothFps:%SmoothFPS%) >> optionsof.txt
(echo ofSmoothWorld:false) >> optionsof.txt
(echo ofAoLevel:0.0) >> optionsof.txt
(echo ofClouds:3) >> optionsof.txt
(echo ofCloudsHeight:0.0) >> optionsof.txt
(echo ofTrees:1) >> optionsof.txt
(echo ofDroppedItems:1) >> optionsof.txt
(echo ofRain:3) >> optionsof.txt
(echo ofAnimatedWater:0) >> optionsof.txt
(echo ofAnimatedLava:0) >> optionsof.txt
(echo ofAnimatedFire:true) >> optionsof.txt
(echo ofAnimatedPortal:true) >> optionsof.txt
(echo ofAnimatedRedstone:true) >> optionsof.txt
(echo ofAnimatedExplosion:true) >> optionsof.txt
(echo ofAnimatedFlame:true) >> optionsof.txt
(echo ofAnimatedSmoke:true) >> optionsof.txt
(echo ofVoidParticles:true) >> optionsof.txt
(echo ofWaterParticles:true) >> optionsof.txt
(echo ofPortalParticles:true) >> optionsof.txt
(echo ofPotionParticles:true) >> optionsof.txt
(echo ofFireworkParticles:true) >> optionsof.txt
(echo ofDrippingWaterLava:true) >> optionsof.txt
(echo ofAnimatedTerrain:true) >> optionsof.txt
(echo ofAnimatedTextures:true) >> optionsof.txt
(echo ofRainSplash:true) >> optionsof.txt
(echo ofLagometer:false) >> optionsof.txt
(echo ofShowFps:false) >> optionsof.txt
(echo ofAutoSaveTicks:4000) >> optionsof.txt
(echo ofBetterGrass:3) >> optionsof.txt
(echo ofConnectedTextures:1) >> optionsof.txt
(echo ofWeather:true) >> optionsof.txt
(echo ofSky:false) >> optionsof.txt
(echo ofStars:true) >> optionsof.txt
(echo ofSunMoon:false) >> optionsof.txt
(echo ofVignette:1) >> optionsof.txt
(echo ofChunkUpdates:1) >> optionsof.txt
(echo ofChunkUpdatesDynamic:false) >> optionsof.txt
(echo ofTime:1) >> optionsof.txt
(echo ofClearWater:false) >> optionsof.txt
(echo ofAaLevel:0) >> optionsof.txt
(echo ofAfLevel:1) >> optionsof.txt
(echo ofProfiler:false) >> optionsof.txt
(echo ofBetterSnow:false) >> optionsof.txt
(echo ofSwampColors:false) >> optionsof.txt
(echo ofRandomEntities:false) >> optionsof.txt
(echo ofSmoothBiomes:false) >> optionsof.txt
(echo ofCustomFonts:false) >> optionsof.txt
(echo ofCustomColors:false) >> optionsof.txt
(echo ofCustomItems:false) >> optionsof.txt
(echo ofCustomSky:%CustomSky%) >> optionsof.txt
(echo ofShowCapes:true) >> optionsof.txt
(echo ofNaturalTextures:false) >> optionsof.txt
(echo ofEmissiveTextures:false) >> optionsof.txt
(echo ofLazyChunkLoading:false) >> optionsof.txt
(echo ofRenderRegions:true) >> optionsof.txt
(echo ofSmartAnimations:false) >> optionsof.txt
(echo ofDynamicFov:true) >> optionsof.txt
(echo ofAlternateBlocks:true) >> optionsof.txt
(echo ofDynamicLights:3) >> optionsof.txt
(echo ofScreenshotSize:1) >> optionsof.txt
(echo ofCustomEntityModels:false) >> optionsof.txt
(echo ofCustomGuis:false) >> optionsof.txt
(echo ofShowGlErrors:true) >> optionsof.txt
(echo ofFullscreenMode:%FullscreenMode%) >> optionsof.txt
(echo ofFastMath:true) >> optionsof.txt
(echo ofFastRender:%FastRender%) >> optionsof.txt
(echo ofTranslucentBlocks:1) >> optionsof.txt
(echo key_of.key.zoom:%Zoom Key-old%) >> optionsof.txt
goto :launch

:1.16
set versionfull=1.16
if exist "%USERPROFILE%\.lunarclient\offline\1.16" (echo.) else goto :noversion
set version=1.16
if '%TweakOptiFineSettings%=='false' (goto :launch) else (goto :newof)
:1.17
set versionfull=1.17
if exist "%USERPROFILE%\.lunarclient\offline\1.17" (echo.) else goto :noversion
set version=1.17
if '%TweakOptiFineSettings%=='false' (goto :launch) else (goto :newof)
:1.12
set versionfull=1.12
if exist "%USERPROFILE%\.lunarclient\offline\1.12" (echo.) else goto :noversion
set version=1.12
if '%TweakOptiFineSettings%=='false' (goto :launch) else (goto :newof)
:newof
if '%TweakOptiFineSettings%=='false' (goto :launch)
(echo ofFogType:3) > optionsof.txt
(echo ofFogStart:0.6) >> optionsof.txt
(echo ofMipmapType:3) >> optionsof.txt
(echo ofOcclusionFancy:false) >> optionsof.txt
(echo ofSmoothFps:%SmoothFPS%) >> optionsof.txt
(echo ofSmoothWorld:false) >> optionsof.txt
(echo ofAoLevel:0.0) >> optionsof.txt
(echo ofClouds:3) >> optionsof.txt
(echo ofCloudsHeight:0.0) >> optionsof.txt
(echo ofTrees:1) >> optionsof.txt
(echo ofDroppedItems:1) >> optionsof.txt
(echo ofRain:3) >> optionsof.txt
(echo ofAnimatedWater:0) >> optionsof.txt
(echo ofAnimatedLava:0) >> optionsof.txt
(echo ofAnimatedFire:true) >> optionsof.txt
(echo ofAnimatedPortal:true) >> optionsof.txt
(echo ofAnimatedRedstone:true) >> optionsof.txt
(echo ofAnimatedExplosion:true) >> optionsof.txt
(echo ofAnimatedFlame:true) >> optionsof.txt
(echo ofAnimatedSmoke:true) >> optionsof.txt
(echo ofVoidParticles:true) >> optionsof.txt
(echo ofWaterParticles:true) >> optionsof.txt
(echo ofPortalParticles:true) >> optionsof.txt
(echo ofPotionParticles:true) >> optionsof.txt
(echo ofFireworkParticles:true) >> optionsof.txt
(echo ofDrippingWaterLava:true) >> optionsof.txt
(echo ofAnimatedTerrain:true) >> optionsof.txt
(echo ofAnimatedTextures:true) >> optionsof.txt
(echo ofRainSplash:true) >> optionsof.txt
(echo ofLagometer:false) >> optionsof.txt
(echo ofShowFps:false) >> optionsof.txt
(echo ofAutoSaveTicks:4000) >> optionsof.txt
(echo ofBetterGrass:3) >> optionsof.txt
(echo ofConnectedTextures:1) >> optionsof.txt
(echo ofWeather:true) >> optionsof.txt
(echo ofSky:false) >> optionsof.txt
(echo ofStars:true) >> optionsof.txt
(echo ofSunMoon:false) >> optionsof.txt
(echo ofVignette:1) >> optionsof.txt
(echo ofChunkUpdates:1) >> optionsof.txt
(echo ofChunkUpdatesDynamic:false) >> optionsof.txt
(echo ofTime:1) >> optionsof.txt
(echo ofAaLevel:0) >> optionsof.txt
(echo ofAfLevel:1) >> optionsof.txt
(echo ofProfiler:false) >> optionsof.txt
(echo ofBetterSnow:false) >> optionsof.txt
(echo ofSwampColors:false) >> optionsof.txt
(echo ofRandomEntities:false) >> optionsof.txt
(echo ofCustomFonts:false) >> optionsof.txt
(echo ofCustomColors:false) >> optionsof.txt
(echo ofCustomItems:false) >> optionsof.txt
(echo ofCustomSky:%CustomSky%) >> optionsof.txt
(echo ofShowCapes:true) >> optionsof.txt
(echo ofNaturalTextures:false) >> optionsof.txt
(echo ofEmissiveTextures:true) >> optionsof.txt
(echo ofLazyChunkLoading:true) >> optionsof.txt
(echo ofRenderRegions:true) >> optionsof.txt
(echo ofSmartAnimations:false) >> optionsof.txt
(echo ofDynamicFov:true) >> optionsof.txt
(echo ofAlternateBlocks:false) >> optionsof.txt
(echo ofDynamicLights:3) >> optionsof.txt
(echo ofScreenshotSize:1) >> optionsof.txt
(echo ofCustomEntityModels:false) >> optionsof.txt
(echo ofCustomGuis:false) >> optionsof.txt
(echo ofShowGlErrors:true) >> optionsof.txt
(echo ofFastMath:true) >> optionsof.txt
(echo ofFastRender:%FastRender%) >> optionsof.txt
(echo ofTranslucentBlocks:1) >> optionsof.txt
(echo ofChatBackground:0) >> optionsof.txt
(echo ofChatShadow:true) >> optionsof.txt
(echo key_of.key.zoom:key.keyboard.left.control) >> optionsof.txt
goto :launch

:launch
for /D %%I in ("%USERPROFILE%\.lunarclient\jre\zulu*") do start "" %%~I\bin\javaw.exe --add-modules jdk.naming.dns --add-exports jdk.naming.dns/com.sun.jndi.dns=java.naming -Djna.boot.library.path=%USERPROFILE%\.lunarclient\offline\%version%\natives --add-opens java.base/java.io=ALL-UNNAMED %JVArguments% -Djava.library.path=%USERPROFILE%\.lunarclient\offline\%version%\natives -XX:+DisableAttachMechanism -cp %USERPROFILE%\.lunarclient\offline\%version%\lunar-assets-prod-1-optifine.jar;%USERPROFILE%\.lunarclient\offline\%version%\lunar-assets-prod-2-optifine.jar;%USERPROFILE%\.lunarclient\offline\%version%\lunar-assets-prod-3-optifine.jar;%USERPROFILE%\.lunarclient\offline\%version%\lunar-libs.jar;%USERPROFILE%\.lunarclient\offline\%version%\lunar-prod-optifine.jar;%USERPROFILE%\.lunarclient\offline\%version%\OptiFine.jar;%USERPROFILE%\.lunarclient\offline\%version%\vpatcher-prod.jar com.moonsworth.lunar.patcher.LunarMain --version %version% --accessToken 0 --assetIndex %versions% --userProperties {} --gameDir %APPDATA%\.minecraft --texturesDir %USERPROFILE%\.lunarclient\textures --width 854 --height 480 & exit

:noversion
CLS
echo %versionfull% not installed, launch it manually once before running again.
pause >nul
exit