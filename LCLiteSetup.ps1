Write-Host "Do you want the source code and run the script as an .AHK script (modifiable, easy to work with) or as a compiled .EXE (no need to install AutoHotKey, less readable/not modifiable"
Write-Host ""
Write-Host "Press E to get the .EXE version, A to press the .AHK version"
CHOICE /C EA /N
if ($lastexitcode -eq '1'){
Clear-Host
mode con cols=80 lines=8
Write-Host "Downloading latest LC Lite release..

If it fails due to Windows Defender false flagging it, consider getting the .AHK version"
pause
$source = "https://github.com/Aetopia/Lunar-Client-Lite-Launcher/releases/latest/download/LCL.exe"
$destination = "$env:localappdata\Microsoft\WindowsApps\LCL.exe"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
Write-Host ""
Write-Host "Download done!"
Unblock-File $destination
Start-Process $destination
exit
}
if ($lastexitcode -eq '2'){
Clear-Host
mode con: cols=75 lines=5
write-host "AutoHotkey is required to use LCL, do you confirm it's installation?"
write-host ""
write-host "Press Y to confirm and install it with Chocolatey, N if you already have AHK or C to Cancel."
choice /C YNC /N 
if ("$lastexitcode" -eq "1") {
Clear-Host
Write-Output "Restarting the script as an Administrator.."
Start-Sleep -Seconds 2
mode con: cols=75 lines=20
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit }

if ($null -eq $env:ChocolateyInstall) {
Clear-Host
Write-Output "Installing Chocolatey
"
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}
Clear-Host
Write-Output "Installing AutoHotkey
"
choco install autohotkey -y --force
}
if ("$lastexitcode" -eq "3") {exit}
Clear-Host
mode con: cols=75 lines=20
Write-Progress "Downloading & setting up LCLite"
Remove-Item "$env:TMP\LCLite.zip" -ErrorAction Ignore
Remove-Item "$env:TMP\LCLite\" -Recurse -ErrorAction Ignore
Remove-Item "$env:TMP\Lunar-Client-Lite-Launcher-main" -Recurse -ErrorAction Ignore
$source = "https://github.com/Aetopia/Lunar-Client-Lite-Launcher/archive/refs/heads/main.zip"
$destination = "$env:TMP\LCLite.zip"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
Expand-Archive -LiteralPath "$env:TMP\LCLite.zip" -DestinationPath "$env:TMP\LCLite\"
Copy-Item "$env:TMP\LCLite\Lunar-Client-Lite-Launcher-main\LCL.ahk" "$env:localappdata\Microsoft\WindowsApps\LunarClientLite.ahk"
Remove-Item "$env:localappdata\Microsoft\WindowsApps\LCL.lnk" -ErrorAction SilentlyContinue
$ShortCutName = "LCL"
$ShortcutTargetPath = "$env:localappdata\Microsoft\WindowsApps\LunarClientLite.ahk"
$ShortCutPath = "$env:localappdata\Microsoft\WindowsApps\"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut("$ShortCutPath$ShortCutName.lnk")
$Shortcut.TargetPath = "$ShortcutTargetPath"
$Shortcut.Save()
Write-Host "Script finished! Type 'LCL' inside of your Run window (Windows+R) to run it"
pause
exit
}