$host.ui.RawUI.WindowTitle = "GraalVM setup for Aetopia's Lunar Client Lite, -couleur"

$GraalVer = "21.2.0" #For anyone replacing this with a newer ver: make sure that version's releases got exactly graalvm-ce-java16-windows-amd64, or then update $source as well
$WR = "$env:LOCALAPPDATA\Microsoft\WindowsApps"
$MC = "$env:APPDATA\.minecraft"
$GraalVM = "$env:ProgramData\GraalVM"
function DownloadGraal{
Write-Output "Downloading GraalVM (319 MB) this may take a while!"
$source = "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$GraalVer/graalvm-ce-java16-windows-amd64-$GraalVer.zip"
$destination = "$env:TMP\GraalVM.zip"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
Write-Output "Unzipping.."
Expand-Archive "$destination" "$env:TMP" -Force
Move-Item "$env:TMP\graalvm-ce-java16-$GraalVer" "$env:ProgramData\GraalVM"
}
if (-not(test-path $mc)){
Write-Output "Minecraft's default directory was not found,"
Write-Output "if you're using a different directory, please indicate it with quotes:"
$MC = Read-Host ".minecraft directory"
}
if (test-path "$GraalVM"){
Write-Output "GraalVM installation detected.

Press D to delete and overwrite
Press S to skip GraalVM installation
Press Q to quit"
choice /C DS
if ($LASTEXITCODE -eq "1"){ #Delete and overwrite
Stop-Process -Name LCL -ErrorAction SilentlyContinue
$AutoHotKey = Get-Process AutoHotKey -ErrorAction SilentlyContinue
if ($AutoHotKey) {
Write-Output "AutoHotkey instance running, make sure you close LCL before continuing"
pause
}
Remove-Item "$GraalVM" -Force -Recurse;DownloadGraal}
if ($LASTEXITCODE -eq "2"){break}
if ($LASTEXITCODE -eq "3"){exit}
}else{DownloadGraal}
Stop-Process -Name LCL -ErrorAction SilentlyContinue
Remove-Item "$WR\LCL.exe" -Force -ErrorAction SilentlyContinue
if (Test-Path "$WR\LCL.lnk"){InstallLCL;$LCLinstalled = "installed"}
if (Test-Path "$WR\LCL.ahk"){InstallLCL;$LCLinstalled = "installed"}
if (Test-Path "$WR\LCL.exe"){InstallLCL;$LCLinstalled = "installed"}
if ($null -eq $LCLinstalled){InstallLCL}

if (Test-Path $WR\LCL.exe -or $WR\LCL.ahk){
Write-Host "Lunar Client Lite installation found, installing.." -ForegroundColor Green
}else {
    Write-Host "Lunar Client Lite installation not found, installing.." -ForegroundColor Red
    Start-Process powershell -ArgumentList "Invoke-RestMethod https://raw.githubusercontent.com/couleur-tweak-tips/utils/main/LCLiteSetup.ps1 | Invoke-Expression" -Wait
}
Write-Output "Setting up Java Arguments.."
"[LC]
Version='1.8'
Arguments=-Xms3G -Xmx3G -XX:+DisableAttachMechanism -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M -XX:+EnableJVMCI -XX:+UseJVMCICompiler -XX:+EagerJVMCI -Djvmci.Compiler=graal
DisableCosmeticTextures=1
Cosmetics=0
[Minecraft]
AssetIndex='1.8'
OptiPatch=0
JRE=$GraalVM\bin\javaw.exe
Assets=$MC\assets
[Language]
Language=English
[Paths]
Legacy=$MC
Modern=$MC
1.7_Dir=$MC
1.8_Dir=$MC
1.12_Dir=$MC\.new
1.16_Dir=$MC\.new
1.17_Dir=$MC\.new" | Set-Content "$WR\config.ini"

Write-Host 'Installation finished!' -ForegroundColor Green

if (test-path "$WR\LCL.lnk"){
    start-process powershell -WindowStyle Hidden -ArgumentList "$WR\LCL.lnk"
    Write-Host 'Press any key to exit' -ForegroundColor DarkGray

    While ( -not [Console]::KeyAvailable ) {Start-Sleep -Milliseconds 15}
    exit
}
if (test-path "$WR\LCL.exe"){
    start-process powershell -WindowStyle Hidden -ArgumentList "$WR\LCL.exe"
    Write-Host 'Press any key to exit' -ForegroundColor DarkGray

    While ( -not [Console]::KeyAvailable ) {Start-Sleep -Milliseconds 15}
    exit
}

