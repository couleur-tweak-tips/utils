# Remove any previous CustomizableLauncher instances to prevent errors.
Remove-Item "$env:localappdata\Microsoft\WindowsApps\CustomizableLauncher.ps1" -ErrorAction SilentlyContinue
Remove-Item "$env:localappdata\Microsoft\WindowsApps\CL.lnk" -ErrorAction SilentlyContinue
#Downloads the customizable launcher
$source = "https://github.com/couleur-tweak-tips/utils/raw/main/CustomizableLauncher.ps1"
$destination = "$env:localappdata\Microsoft\WindowsApps\CustomizableLauncher.ps1"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
#Makes the shortcut
$ShortCutName= "CL"
$ShortCutArguments= "iex $env:localappdata\Microsoft\WindowsApps\CustomizableLauncher.ps1"
$ShortcutTargetPath= "powershell"
$ShortCutPath="$env:localappdata\Microsoft\WindowsApps\"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut("$ShortCutPath$ShortCutName.lnk")
$Shortcut.TargetPath = "$ShortcutTargetPath"
$Shortcut.Arguments = "$ShortCutArguments"
$Shortcut.Save()
# Launches the shortcut (powershell needs to specify the .lnk but via Run you don't)
powershell iex cl.lnk



