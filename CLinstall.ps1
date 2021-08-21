if (Test-Path "$env:windir\system32\WindowsPowerShell\v1.0\powershell.exe") {
# Remove any previous CustomizableLauncher installs to prevent errors.
Remove-Item "$env:localappdata\Microsoft\WindowsApps\CustomizableLauncher.ps1"-Force -ErrorAction SilentlyContinue
Remove-Item "$env:localappdata\Microsoft\WindowsApps\CL.lnk"-Force -ErrorAction SilentlyContinue
Remove-Item "$env:localappdata\Microsoft\WindowsApps\CL.bat"-Force -ErrorAction SilentlyContinue
#Downloads the customizable launcher
$source = "https://github.com/couleur-tweak-tips/utils/raw/main/CustomizableLauncher.ps1"
$destination = "$env:localappdata\Microsoft\WindowsApps\CustomizableLauncher.ps1"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
#Makes the shortcut
"title CL.bat & mode con lines=1 cols=30
powershell Set-ExecutionPolicy Unrestricted -Scope Process -Force;%localappdata%\Microsoft\WindowsApps\CustomizableLauncher.ps1 %1 %2 %3 %4 %5 %6 %7 %8 %9
exit" | Set-Content $env:localappdata\Microsoft\WindowsApps\CL.bat
# Launches the batch (powershell needs to specify the .bat but via Run you don't)
Start-Process cl.bat
exit
}else{
Write-Host "Powershell hasn't been detected on your system, please re-enable it in optional features"
timeout 3
start-process optionalfeatures
exit
}



