if (-not (Test-Path $env:ChocolateyInstall)) {
Write-Progress "Installing Chocolatey"
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}


Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}
if (-not (Test-Path "$env:ProgramData\chocolatey\bin\AutoHotkey.exe")) {
Write-Progress "Installing AutoHotkey"
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}

choco install autohotkey -y -force
}
Write-Progress "Downloading & setting up LCLite"
# iwr -useb -uri "https://github.com/Aetopia/Lunar-Client-Lite-Launcher/archive/refs/heads/main.zip" | Out-File "$env:TMP\LCL.zip"
$source = "https://github.com/Aetopia/Lunar-Client-Lite-Launcher/archive/refs/heads/main.zip"
$destination = "$env:TMP\LCLite.zip"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
Expand-Archive -LiteralPath "$env:TMP\LCLite.zip" -DestinationPath "$env:TMP\LCLite"
Copy-Item "$env:TMP\LCLite\Lunar-Client-Lite-Launcher-main\LCL.ahk" "$env:localappdata\Microsoft\WindowsApps\LCL.ahk"