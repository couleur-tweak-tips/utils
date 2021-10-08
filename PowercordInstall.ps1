$Host.UI.RawUI.WindowTitle = "Powercord installer for Discord Canary - Couleur"

if (Test-Path "$home\Powercord"){
    Write-Warning "A Powercord installation was found on your system
    
- Press D to delete your current installation and continue
- Press C to continue anyway
- Press O to open your existing Powercord installation's directory
- Press E to exit"
choice /C DCOE /N
    switch ($LASTEXITCODE){
        1{
            Stop-Process -Name DiscordCanary -Force -ErrorAction Suspend
            Remove-Item "$home\Powercord" -Force -Recurse -ErrorAction Suspend
        }
        2{break}
        3{explorer.exe $home\Powercord;exit}
        4{exit}
    }
}

function InstallDiscordCanary {
    Write-Host 'Downloading Discord Canary (72.2MB).. ' -NoNewline
    $webClient = [System.Net.WebClient]::new()
    $webClient.DownloadFile("https://discord.com/api/download/canary?platform=win", "$env:TMP\DiscordCanary.exe")
    Write-Output 'Done! Running the installer..'
    Start-Process "$env:TMP\DiscordCanary.exe"
    Write-Output ''
    Write-Output 'Press C to continue after Discord Canary has finished installing itself.. (You do not need to log in)'
    choice /C C /N
    if ($LASTEXITCODE = 'C'){}
}
function InstallScoop {
    Write-Warning 'Missing dependencies were found, installing package manager ''scoop'' to fill them'
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/lukesampson/scoop/master/bin/install.ps1'))
    $NeedsIntall = $false
}
$ScoopPath = Get-Command scoop.ps1 -ErrorAction SilentlyContinue
if (!($ScoopPath.path)){$NeedsIntall = $true}else{$NeedsIntall = $false}

#REGION - Checking if the right Discord edition is installed
$DiscordCanaryProcessStatus = Get-Process -Name DiscordCanary -ErrorAction SilentlyContinue
$DiscordProcessStatus = Get-Process -Name Discord -ErrorAction SilentlyContinue
if ($DiscordProcessStatus){
    Write-Warning 'Powercord only supports Discord Canary
    
    Press C to continue installation anyway (will probably fail to plug)
    Press I to install Discord Canary (passive)
    Press E to exit'
    choice /N
    switch ($LASTEXITCODE){
        1 {break}
        2 {InstallDiscordCanary}
        3 {exit}
    }
}elseif ($DiscordCanaryProcessStatus) {
    Write-Output 'Disord Canary cannot be running during the installation of Powercord'
    Write-Host 'Closing..' -NoNewline
    Stop-Process -Name DiscordCanary -Force -ErrorAction Stop
    Write-Host 'ok'
    start-sleep 3
}elseif ((Test-Path 'Registry::HKEY_CLASSES_ROOT\Discord') -eq $true){

        $CanaryDetect = (Get-ItemProperty -Path 'Registry::HKEY_CLASSES_ROOT\Discord\DefaultIcon').'(Default)' | Select-String 'Canary'
        if (!($null -eq $CanaryDetect)){
            Write-Output "Non-Canary Discord installation detected
            Powercord is only compatible with Discord canary
            
            Would you like to intall it?
            
            Press I to install DiscordCanary before continuing with the installation
            Press C to continue the installation anyway
            Press E to exit"
            choice /C ICE /N
            switch ($LASTEXITCODE){
                1 {InstallDiscordCanary}
                2 {}
                3 {exit}
            }
    
        }
    }elseif ((Test-Path 'Registry::HKEY_CLASSES_ROOT\Discord') -eq $false){
        Write-Host 'No Discord installations were detected, would you like to install Discord Canary?
        
        Press I to install DiscordCanary before continuing with the installation
        Press C to continue the installation anyway
        Press E to exit'
        choice /C ICE /N
        switch ($LASTEXITCODE){
            1 {InstallDiscordCanary}
            2 {}
            3 {exit}
        }
    }
#endregion

#REGION - Other Dependencies (Git, NodeJS and Powercord)



$npmCommand = Get-Command npm -ErrorAction SilentlyContinue
if ($npmCommand.Path){
    $npmVer = npm -version

    
    Write-Host "npm version $npmVer found" -ForegroundColor Green
}else{ # Installing npm
    if ($NeedsIntall -eq $true){InstallScoop}
    Write-Host 'installing NodeJS (LTS)..' -ForegroundColor Red
    scoop install NodeJS-LTS
}
$gitCommand = Get-Command git -ErrorAction SilentlyContinue
if ($gitCommand.Path){
    $gitVer = git --version
    Write-Host "$gitVer found, continuing" -ForegroundColor Green
}else{ # Installing git
    if (!(Test-Path "$home\scoop\shims\scoop.ps1")){Start-Sleep 2;InstallScoop}
Write-Host 'installing git..' -ForegroundColor Red
    scoop install git
}
#endregion

#REGION - 
Write-Host "Where do you want to intall Powercord?

Leave blank and type enter to set it to $home\Powercord"

Write-Host "(^ This is the recommended default, added this prompt just in case)" -ForegroundColor DarkGray
$PowercordDir = Read-Host 'Powercord Directory'
if ($PowercordDir -eq ''){$PowercordDir = "$home"}

Set-Location $PowercordDir
git clone https://github.com/powercord-org/powercord
Set-Location .\powercord
npm i
npm run plug
pause