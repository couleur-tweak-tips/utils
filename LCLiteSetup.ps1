mode con: cols=75 lines=5
write-host "AutoHotkey is required to use LCL, do you confirm it's installation?"
write-host ""
write-host "Press Y to confirm and install, N if you already have AHK or C to Cancel."
choice /C YNC /N 
cls
mode con: cols=75 lines=20
if ($lastexitcode -eq "3") {exit}
if ($lastexitcode -eq "1") {
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}
if (-not (Test-Path -Path $env:ChocolateyInstall)) {
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}
choco install autohotkey -y --force
}
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

