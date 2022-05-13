$GraalVMVersion = '21.2.0'
$Uri = "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$GraalVMVersion/graalvm-ce-java16-windows-amd64-$GraalVMVersion.zip"
$ErrorActionPreference = 'Inquire'

if (!($(Get-Command curl.exe -ErrorAction SilentlyContinue).Source)){
    "curl is not installed (comes with windows per default)
    
    Installing curl via scoop"

    $scoop = (Get-Command scoop -ea SilentlyContinue).Source
    if (!($scoop)){
        Invoke-RestMethod get.scoop.sh | Invoke-Expression
    }
    scoop install curl
    $curl = (Get-Command curl.exe).Source
}else{$curl = (Get-Command curl.exe).Source}

function DeleteGraalVM{
    try {
        "Deleting GraalVM.."
        Remove-Item $env:ProgramData\GraalVM -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "$env:ProgramData\graalvm-ce-java16-21.2.0" -Recurse -Force -ErrorAction SilentlyContinue
    }catch{
        "Failed to delete GraalVM, closing Minecraft.."
        Stop-Process -Name javaw -ErrorAction SilentlyContinue
        Stop-Process -Name Minecraft -ErrorAction SilentlyContinue
        Remove-Item $env:ProgramData\GraalVM -Recurse -Force
    }
Remove-Item "$env:ProgramData\graalvm-ce-java16-21.2.0" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ProgramData\GraalVM.zip" -Recurse -Force -ErrorAction SilentlyContinue
}

if (Test-path $env:ProgramData\GraalVM\bin\javaw.exe){
"GraalVM is already installed

Press R to delete and reinstall
Press S to skip to LCL configuration / continue anyway
Press E to exit"
choice.exe /C RSE /N
if ($lastexitcode -eq 1){
    DeleteGraalVM
    "GraalVM was successfully deleted, press any key to exit"
    pause
    exit
}
if ($lastexitcode -eq 3){exit}
}

$Destination = "$env:TMP\GraalVM.zip"
$ZipSize = (Get-Item $Destination -ErrorAction SilentlyContinue).Length
$ZipExist = Test-Path "$env:TMP\GraalVM.zip"
if (!($ZipExist -or $ZipSize -eq 326978779)){
    Remove-Item $env:TMP\GraalVM.zip -Ea SilentlyContinue
    Remove-Item $env:TMP\GraalVM -Recurse -Force -Ea SilentlyContinue

    $Size = (Invoke-WebRequest -Useb $Uri -Method Head).Headers.'Content-Length'
    $Size = $("$size"/1MB).ToString("#.##").Replace(',','.')
    "Downloading GraalVM ($($Size)MB)"
    Start-Process -NoNewWindow $curl -ArgumentList "-L -# -o $($Destination) $($Uri)" -Wait
}
Expand-Archive $Destination $env:ProgramData
Rename-Item "$env:ProgramData\graalvm-ce-java16-21.2.0" "$env:ProgramData\GraalVM"
function PatchLCL ($LCLExecutable){
$Dir = Split-Path $LCLExecutable
$MC = "$env:APPDATA\.minecraft"
"[LC]
Version='1.8'
Arguments=-Xms3G -Xmx3G -XX:+DisableAttachMechanism -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M -XX:+EnableJVMCI -XX:+UseJVMCICompiler -XX:+EagerJVMCI -Djvmci.Compiler=graal
DisableCosmeticTextures=1
Cosmetics=0
[Minecraft]
AssetIndex='1.8'
OptiPatch=0
JRE=$env:ProgramData\GraalVM\bin\javaw.exe
Assets=$MC\assets
[Language]
Language=English
[Paths]
Legacy=$MC
Modern=$MC
1.7_Dir=$MC
1.8_Dir=$MC
1.12_Dir=$MC
1.16_Dir=$MC
1.17_Dir=$MC" | Set-Content "$Dir\config.ini"
}


$WR = "$env:LOCALAPPDATA\Microsoft\WindowsApps"
if ((Test-Path "$WR\LCL.exe") -or (Test-Path "$WR\LCL.ahk")){
    PatchLCL "$WR\LCL.exe"
    "Lunar Client Lite config patched with GraalVM JRE path / JVA arguments"
    "If you have a custom directory for Minecraft, make sure you set them back up again"
    pause
    exit
}else{
"Lunar Client Lite is not installed (or not in the default directory)

LCL is needed in order to launch Lunar Client with it

Press S to specify where LCL is installed
Press I to install LCL
Press C If you're not using LCL"
choice /C SIC /N
switch ($LASTEXITCODE){
    1{$CustomLCLDir = Read-Host "Drag in your LCL executable"
    PatchLCL $CustomLCLDir
    exit
    }
    2{
        $ScriptURL = "https://raw.githubusercontent.com/couleur-tweak-tips/utils/main/Installers/LunarClientLite.ps1"
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("$ScriptURL"))
        exit
    }
    3{
        "JRE path: $env:ProgramData\GraalVM\bin\javaw.exe
        
        Recommended JVA: -Xms3G -Xmx3G -XX:+DisableAttachMechanism -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M -XX:+EnableJVMCI -XX:+UseJVMCICompiler -XX:+EagerJVMCI -Djvmci.Compiler=graal
        DisableCosmeticTextures=1
        
        Press any key to exit"
        pause
        exit
    }
}
}
