
# I was bored and wanted to play with PowerShell, so I made this
# If you wish to use this regularly I strongly recommend you usemy customizable launcher
# you install it with the following command: iwr cl.couleur.tech | iex
# Then you can use Run (Windows+R) and call this script easily by typing cl i nmkoder

$NmkoderDir = "$home\Downloads"
# Set where you wish to save Nmkoder

$latest = (Invoke-RestMethod -Method GET -Uri "https://api.github.com/repos/n00mkrad/nmkoder/releases")[0].tag_name
$destination = "$env:TMP\Nmkoder.zip"
if (-not (Test-Path "$NmkoderDir\Nmkoder")){$install = $true}
if (Test-Path "$NmkoderDir\NMkoder\version.txt"){
$install = $false
$local = Get-Content "$NmkoderDir\NMkoder\version.txt"
if ($latest -gt $local){
Write-Output "Current version is $local, but $latest is out! Reinstalling NMkoder.."
Start-Sleep 2
Stop-Process -Name "Nmkoder" -ErrorAction SilentlyContinue
Stop-Process -Name "ff-utils-winforms" -ErrorAction SilentlyContinue
Remove-Item "$NmkoderDir\NMkoder" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$Destination" -Force -ErrorAction SilentlyContinue
$install = $true
}
}
if ($install -eq $true){
$source = (Invoke-RestMethod -Method GET -Uri "https://api.github.com/repos/n00mkrad/nmkoder/releases")[0].assets.browser_download_url
$webClient = [System.Net.WebClient]::new()
Write-Output "Downloading Nmkoder $latest.."
$webClient.DownloadFile($source, $destination)
Expand-Archive "$destination" "$NmkoderDir"
Remove-Item "$Destination" -Force -ErrorAction SilentlyContinue
(Invoke-RestMethod -Method GET -Uri "https://api.github.com/repos/n00mkrad/nmkoder/releases")[0].tag_name | Set-Content "$NmkoderDir\NMkoder\version.txt"
Start-Process "$NmkoderDir\Nmkoder"
#exit
"exit"
}
Start-Process "$NmkoderDir\Nmkoder\Nmkoder.exe"