Write-Output "Removing any previous CustomizableLauncher installs to prevent errors..."
$WindowsAppsDir = "$env:localappdata\Microsoft\WindowsApps"
Remove-Item "$WindowsAppsDir\CustomizableLauncher.ps1"-Force -ErrorAction SilentlyContinue
Remove-Item "$WindowsAppsDir\CL.lnk"-Force -ErrorAction SilentlyContinue
Remove-Item "$WindowsAppsDir\CL.bat"-Force -ErrorAction SilentlyContinue
Write-Output "Downloading the CL.."
$source = "https://github.com/couleur-tweak-tips/utils/raw/main/CustomizableLauncher.ps1"
$destination = "$WindowsAppsDir\CustomizableLauncher.ps1"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
Write-Output "Setting up the shortcut.."
"title CL.bat & mode con lines=1 cols=30
powershell Set-ExecutionPolicy Unrestricted -Scope Process -Force;%localappdata%\Microsoft\WindowsApps\CustomizableLauncher.ps1 %1 %2 %3 %4 %5 %6 %7 %8 %9
exit" | Set-Content $WindowsAppsDir\CL.bat
# Launches the batch (powershell needs to specify the .bat but via Run, you don't)
Write-Output "Launching.."
Start-Process cl.bat
exit

