# ALL CREDITS GO TO https://github.com/bcurran3/ChocolateyPackages/tree/master/choco-protocol-support
# I just replaced choco by mpv and litely edited the parsing .cmd

# Setup mpv:// Protocol in the registry and assign it to run choco-protocol-support.cmd which in turn runs cinst.exe with help from Sudo


# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
    }
}

# Makes a directory I'll also use to put my other stuff in in the future
if (-not (test-path "$env:ProgramData\CTT")){mkdir "$env:ProgramData\CTT"}
if (test-path "$env:ProgramData\CTT\mpv-protocol"){
Write-Output "mpv-protocol support folder already exists

Press C to confirm reinstallation
Press Q to quit"
choice /C CQ /N
if ($LASTEXITCODE -eq '1'){Remove-Item "$env:ProgramData\CTT\mpv-protocol" -Recurse -Force -ErrorAction SilentlyContinue}
if ($LASTEXITCODE -eq '2'){exit}
}
if ($null -eq (get-command mpv.exe -ErrorAction SilentlyContinue).Path){
    Write-Output "MPV wasn't found/added to the path, would you like to install it with Chocolatey? [Y/N]"
choice /N
if ($LASTEXITCODE -eq '1'){
    if (-not(Test-Path $env:ProgramData\chocolatey\bin\cup.exe)){
        "Installing Chocolatey..";Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        & "$env:ProgramData\chocolatey\bin\RefreshEnv.cmd"}
        cup mpv -y -force}
}
Clear-Host
mkdir "$env:ProgramData\CTT\mpv-protocol"
$wrapperPath = "$env:ProgramData\CTT\mpv-protocol\mpv-protocol-wrapper.cmd"
Write-Output "Adding the registry keys to handle mpv protocol and redirect to wrapper"
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ea SilentlyContinue | Out-Null
New-Item -Path "HKCR:" -Name "mpv" –Force | Out-Null
Set-ItemProperty -Path "HKCR:\mpv" -Name "(Default)" -Value '"URL:mpv Protocol"' | Out-Null
Set-ItemProperty -Path "HKCR:\mpv" -Name "URL Protocol" -Value '""' | Out-Null
New-Item -Path "HKCR:\mpv" -Name "shell" –Force | Out-Null
New-Item -Path "HKCR:\mpv\shell" -Name "open" –Force | Out-Null
New-Item -Path "HKCR:\mpv\shell\open" -Name "command" –Force | Out-Null
Set-ItemProperty -Path "HKCR:\mpv\shell\open\command" -Name "(Default)" -Value  """$env:ProgramData\CTT\mpv-protocol\mpv-protocol-wrapper.cmd"" ""%1""" | Out-Null

Write-Output "Setting the wrapper up"
"title MPV protocol handler -cl, originally for choco by bcurran3
set mpvprotocolURL=%1
set protocol=https://
set mpvprotocolURL=%protocol%%mpvprotocolURL:~14,-1%%
start mpv.exe %mpvprotocolURL%&exit" | Set-Content $wrapperPath
Write-Output "Finished"
Start-sleep 2