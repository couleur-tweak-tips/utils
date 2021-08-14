$Host.UI.RawUI.WindowTitle = "Voukoder Installer & Connector -couleur"
cls
mode con cols=80 lines=9
if (Test-Path $env:ProgramFiles\Voukoder) {
Write-Host "WARNING: A voukoder installation was already found on your system, if you wish  to update Voukoder, uninstall the old one first"
timeout 12
Start-Process ms-settings:appsfeatures
exit
}else{
"Downloading & installing Voukoder Core.."
$download_url = ((Invoke-RestMethod -Method GET -Uri https://api.github.com/repos/Vouk/voukoder/releases/latest).assets | Where-Object name -like "voukoder-*.msi" ).browser_download_url
$local_path = "$env:TEMP\VoukoderInstaller.msi"
Remove-Item  $local_path -Force -ErrorAction SilentlyContinue
$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile($download_url, $local_path)
#Start-Process $local_path -Wait
msiexec -i "$env:TEMP\VoukoderInstaller.msi" -passive
cls;Write-Host "Voukoder Core successfully installed, continuing.."
timeout 1
While (1){
cls
Write-Host "Select which editing software connector you'd like to download & install"
Write-Host ''
Write-Host "Press N to connect it with Vegas Pro 18.0"
Write-Host "Press O to connect it with any older versions of Vegas"
Write-Host "Press P to connect it with Adobe Premiere Pro"
Write-Host "Press A to connect it with Adobe AfterEffects"
Write-Host "Press R to connect it with DaVinci Resolve"
Write-Host "Press E to exit"
choice /C NOPARE /N
if ($LASTEXITCODE -eq "1"){cls; # 1: Vegas Pro 18.0
$Connector = "Vegas Pro 18.0"
$ConnectorVer = "0.9.11"
$download_url = "https://github.com/Vouk/voukoder-connectors/raw/master/vegas/vegas18-connector-$ConnectorVer.msi"}
if ($LASTEXITCODE -eq "2"){cls; # 2: Vegas 12.0-17.0
$Connector = "Vegas Pro 12.0 - 17.0"
$ConnectorVer = "1.1.0"
$download_url = "https://github.com/Vouk/voukoder-connectors/raw/master/vegas/vegas-connector-$ConnectorVer.msi"}
if ($LASTEXITCODE -eq "3"){cls; # 3: Premiere Pro
$Connector = "Adobe Premiere Pro CS6+ CC"
$ConnectorVer = "1.8.0"
$download_url = "https://github.com/Vouk/voukoder-connectors/raw/master/premiere/premiere-connector-$ConnectorVer.msi"}
if ($LASTEXITCODE -eq "4"){cls; # 4: AfterEffects
$Connector = "After Effects"
$ConnectorVer = "0.9.6"
$download_url = "https://github.com/Vouk/voukoder-connectors/raw/master/aftereffects/aftereffects-connector-$ConnectorVer.msi"}
$local_path = "$env:TEMP\VoukoderConnector.msi"
if ($LASTEXITCODE -eq "5"){cls; # 5: DaVinci Resolve
$Connector = "DaVinci Resolve"
$ConnectorVer = "0.7.0"
$download_url = "https://github.com/Vouk/voukoder-connectors/raw/master/resolve/resolve-connector-$ConnectorVer.zip"}
if ($LASTEXITCODE -eq "6"){exit}# 6: Exit
cls
Write-Host "Laucnhing Voukoder connector for $Connector.."
Write-Host ''
Write-Host "Make sure you select the right installation path of $Connector"
$local_path = "$env:TEMP\VoukoderConnector.msi"
Remove-Item  $local_path -Force -ErrorAction SilentlyContinue
$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile($download_url, $local_path)
Start-Process $local_path -Wait
}
}