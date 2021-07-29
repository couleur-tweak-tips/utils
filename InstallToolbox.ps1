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
Remove-Item -Path "$env:homedrive$env:homepath\Desktop\couleurstoolbox" -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "$env:homedrive$env:homepath\Desktop\CTT Toolbox" -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "$env:TEMP\toolbox.zip" -Force -Recurse -ErrorAction SilentlyContinue

cls;Write-Host Downloading the latest version of the toolbox
Invoke-WebRequest -UseBasicParsing https://github.com/couleurm/couleurstoolbox/archive/refs/heads/main.zip -OutFile $env:TEMP\toolbox.zip -ErrorAction SilentlyContinue

cls;Write-Host Unzipping..
Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{param([string]$zipfile, [string]$outpath)
[System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)}
Unzip "$env:TEMP\toolbox.zip" "$env:homedrive$env:homepath\Desktop"

if ($LASTEXITCODE -ne 0 ) {cls;echo 'Compression failed, using basic powershell instead'; timeout 1;Expand-Archive -LiteralPath $env:TEMP\toolbox.zip -DestinationPath "$env:homedrive$env:homepath\Desktop" -ErrorAction SilentlyContinue}

Remove-Item -Path "$env:TEMP\toolbox.zip" -Force -Recurse -ErrorAction SilentlyContinue
cls;Write-Host Renaming..
$ToolboxName='CTT Toolbox'
Rename-Item "$env:homedrive$env:homepath\Desktop\couleurstoolbox-main" "$env:homedrive$env:homepath\Desktop\$ToolboxName"
cls;Write-Host Install done, opening the toolbox..
sleep 1;Start-Process "$env:homedrive$env:homepath\Desktop\$ToolboxName";exit