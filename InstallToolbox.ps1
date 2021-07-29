# This downloads the previous toolbox if there ever was one
# Installs Chocolatey
# Installs FFmpeg with Chocolatey
# Downloads the latest version of the toolbox
$uac =@'
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {$CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments; Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine; Exit}}
'@ # This is just a variable to launch UAC if required.

#Check if Chocolatey is installed.
if (Test-Path '$env:chocolateyinstall') {$uac; Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))}
else {refreshenv;cls;Write-Host "Chocolatey already exists, skipping"}

# Check if FFmpeg is installed with Chocolatey, if not then choco installs it
if (Test-Path "C:\ProgramData\chocolatey\bin\ffmpeg.exe") {cls; Write-Host "ffmpeg already exists, skipping"}
else {$uac; choco install ffmpeg -y}
Write-Host Removing the current toolboxes
Remove-Item -Path "$env:homedrive$env:homepath\Desktop\couleurstoolbox" -Force -Recurse | Out-Null
Remove-Item -Path "$env:homedrive$env:homepath\Desktop\CTT Toolbox" -Force -Recurse | Out-Null
Remove-Item -Path "$env:TEMP\toolbox.zip" -Force -Recurse | Out-Null
cls;Write-Host Downloading the latest version of the toolbox
Invoke-WebRequest -UseBasicParsing https://github.com/couleurm/couleurstoolbox/archive/refs/heads/main.zip -OutFile $env:TEMP\toolbox.zip | Out-Null
cls;Write-Host Unzipping..
Expand-Archive -LiteralPath $env:TEMP\toolbox.zip -DestinationPath "$env:homedrive$env:homepath\Desktop" | Out-Null
Remove-Item -Path "$env:TEMP\toolbox.zip" -Force -Recurse | Out-Null
cls;Write-Host Renaming..
$ToolboxName='CTT Toolbox'
Rename-Item "$env:homedrive$env:homepath\Desktop\couleurstoolbox-main" "$env:homedrive$env:homepath\Desktop\$ToolboxName"
cls;Write-Host Install done, opening the toolbox..
sleep 1;Start-Process "$env:homedrive$env:homepath\Desktop\$ToolboxName";exit