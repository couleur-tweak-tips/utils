# 1. Downloads & moves DDU to Downloads
# 2. Prompts user to choose between NVCleanstall, NVSlimmer or AMD

Write-host "Downloading DDU.."
Remove-Item "$env:TEMP\DDU.zip" -ErrorAction SilentlyContinue -Recurse
Remove-Item "$env:TEMP\DisplayDriverUninstaller" -ErrorAction SilentlyContinue -Recurse
Remove-Item "$home\downloads\DDU" -ErrorAction SilentlyContinue -Recurse
$source = "https://ftp.nluug.nl/pub/games/PC/guru3d/ddu/[Guru3D.com]-DDU.zip"
$destination = "$env:TEMP\DDU.zip"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
Expand-Archive $destination $env:TEMP\DisplayDriverUninstaller
Start-Process "$env:TEMP\DisplayDriverUninstaller\DDU*.exe" -ArgumentList '-y' -Wait
cd "$env:TEMP\DisplayDriverUninstaller\DDU*.*.*"
Move-Item .\* -Destination "$home\downloads\DDU"
Write-Host "Download done! DDU should now be in your Downloads folder"
timeout 2
cls
write-host "Which driver installer would you like to use?"
write-host ""
write-host "Press C for NVCleanstall, S for NVSlimmer, A for AMD and Q to quit"
choice /C CSAQ /N 

if ($LASTEXITCODE -eq "1") {
Remove-Item "$home\Downloads\NVCleanstall.exe" -ErrorAction SilentlyContinue
# NVCleanstall can't be parsed sadly, gotta self-host via DiscordCDN.. sorry
# SHA256 for version 1.10.0 should be DBBA3DE024EC18D5D4E044990DB4F12B3BD4362791419471F1467CCF8243B11D
$NCver = "1.10.0"
$source = "https://cdn.discordapp.com/attachments/843853887847923722/870039242821234718/NVCleanstall_$NCver.exe"
$destination = "$home\Downloads\NVCleanstall.exe"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
Start-Process "$home\Downloads\"
Exit}

if ($LASTEXITCODE -eq "2"){
#                                            NVSlimmer
Remove-Item "$home\Downloads\NVSlimmer" -Recurse -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\NVSlimmer.zip" -ErrorAction SilentlyContinue
$source = 'https://ftp.nluug.nl/pub/games/PC/guru3d/nvslimmer/[Guru3D.com]-NVSlimmer.zip'
$destination = "$env:tmp\NVSlimmer.zip"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
Expand-Archive "$env:TEMP\NVSlimmer.zip" "$env:temp\NVSlimmer"
Move-Item "$env:temp\NVSlimmer" "$home\Downloads\"
$ShortCutName="!Browser link to NVIDIA's advanced driver search"
$ShortcutTargetPath = "https://www.nvidia.com/Download/Find.aspx"
$ShortCutPath="$home\Downloads\NVSlimmer\"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut("$ShortCutPath$ShortCutName.lnk")
$Shortcut.TargetPath = "$ShortcutTargetPath"
$Shortcut.Save()
Remove-Item "$home\Downloads\NVSlimmer\Guru3D.com\" -Recurse -ErrorAction SilentlyContinue
start "$home\Downloads\NVSlimmer"
Exit}

if ($LASTEXITCODE -eq "3"){
Write-Host "Opening the AMD driver download page.."
timeout 2
start https://www.amd.com/support
Exit}

if ($LASTEXITCODE -eq "4") {Exit}