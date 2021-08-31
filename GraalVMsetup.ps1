$host.ui.RawUI.WindowTitle = "GraalVM setup for Aetopia's LC Lite, -couleur"
function DownloadFile{$webClient = [System.Net.WebClient]::new();$webClient.DownloadFile($source, $destination)}
$WR = "$env:LOCALAPPDATA\Microsoft\WindowsApps"
$MC = "$env:APPDATA\.minecraft"
if (-not(test-path $mc)){
Write-Output "Minecraft's default directory was not found,"
Write-Output "if you're using a different directory, please indicate it with quotes:"
$MC = Read-Host "Minecraft Path:"
}
$GraalVM = "$env:ProgramData\GraalVM"
$source = "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-21.2.0/graalvm-ce-java16-windows-amd64-21.2.0.zip"
$destination = "$env:TMP\GraalVM.zip"
if (-not(test-path $destination)){Write-Output "Downloading GraalVM (319 MB) this may take a while!";DownloadFile}
if (test-path "$GraalVM"){
    $GraalVMdetection = "1"
    Write-Output "GraalVM installation detected."
    Write-Output ""
    Write-Output "Press D to delete and overwrite"
    Write-Output "Press S to skip"
choice /C DS
if ($LASTEXITCODE -eq "1"){Remove-Item "$GraalVM";mkdir "$GraalVM" Expand-Archive "$destination" "$GraalVM"}
if ($LASTEXITCODE -eq "2"){}
}
if ($null -eq $GraalVMdetection){if (-not(Test-Path "$GraalVM")){mkdir "$GraalVM"}}
if ($null -eq $GraalVMdetection){Expand-Archive "$destination" "$GraalVM"}
taskkill /IM LCL.exe /F
Remove-Item "$WR\LCL.exe" -Force -ErrorAction SilentlyContinue
if (-not(Test-Path "$WR\LCL.lnk")){Write-Output "Installing LCL..";Start-Process powershell -ArgumentList "irm https://raw.githubusercontent.com/couleur-tweak-tips/utils/main/LCLiteSetup.ps1 | iex" -Wait}

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
[Paths]
Legacy=$MC
Modern=$MC
1.7_Dir=$MC
1.8_Dir=$MC
1.12_Dir=$MC\.new
1.16_Dir=$MC\.new
1.17_Dir=$MC\.new" | Set-Content "$WR\config.ini"

Start-Process LCL.lnk