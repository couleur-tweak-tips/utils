# This downloads the previous toolbox if there ever was one
# Installs Chocolatey
# Installs FFmpeg with Chocolatey
# Downloads the latest version of the toolbox


#region UAC
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}
#endregion
#region dependencies
 if (-not (Test-Path C:\ProgramData\chocolatey\choco.exe -PathType Leaf)) {
    echo Installing Chocolatey
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
 if (-not (Test-Path C:\ProgramData\chocolatey\bin\ffmpeg.exe -PathType Leaf)) {
    cls
    echo Installing FFmpeg
    choco feature enable -n allowGlobalConfirmation
    choco install ffmpeg
}
#endregion
#region installation
cls
Write-Host Removing the current toolbox
Remove-Item -Path "$env:homedrive$env:homepath\Desktop\couleurstoolbox" -Force -Recurse
Remove-Item -Path "$env:homedrive$env:homepath\Desktop\CTT Toolbox" -Force -Recurse
cls
Write-Host Downloading the latest version of the toolbox
Invoke-WebRequest -UseBasicParsing https://github.com/couleurm/couleurstoolbox/archive/refs/heads/main.zip -OutFile $env:TEMP\toolbox.zip
cls
Write-Host Unzipping..
Expand-Archive -LiteralPath $env:TEMP\toolbox.zip -DestinationPath "$env:homedrive$env:homepath\Desktop"
cls
Write-Host Renaming..
$ToolboxName='CTT Toolbox'
Rename-Item "$env:homedrive$env:homepath\Desktop\couleurstoolbox-main" "$env:homedrive$env:homepath\Desktop\$ToolboxName"
cls
write-Host Install done, opening the toolbox.
sleep 1
Start-Process "$env:homedrive$env:homepath\Desktop\$ToolboxName"
exit
#endregion