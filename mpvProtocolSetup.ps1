# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
    }
}

if (-not (test-path "$env:ProgramData\CTT")){mkdir "$env:ProgramData\CTT"}
if (test-path "$env:ProgramData\CTT\mpv-protocol"){
"mpv-protocol support folder already exists

Press C to confirm reinstallation
Press Q to quit"
choice /C CQ /N
if ($LASTEXITCODE -eq '1'){Clear-Host}
if ($LASTEXITCODE -eq '2'){exit}
}
$mpv = (get-command mpv.exe).Path
if ($null -eq $mpv){

    if (-not(Test-Path $env:ProgramData\chocolatey\bin\cup.exe)){
        "Installing Chocolatey..";Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        & "$env:ProgramData\chocolatey\bin\RefreshEnv.cmd"}
        cup mpv -y -force

}
mkdir "$env:ProgramData\CTT\mpv-protocol"
$wrapperPath = "$env:ProgramData\CTT\mpv-protocol\mpv-protocol-wrapper.cmd"
# ALL CREDITS GO TO https://github.com/bcurran3/ChocolateyPackages/tree/master/choco-protocol-support
# I just replaced choco by mpv and litely edited the parsing .cmd

# Setup mpv:// Protocol in the registry and assign it to run choco-protocol-support.cmd which in turn runs cinst.exe with help from Sudo
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ea SilentlyContinue | Out-Null
New-Item -Path "HKCR:" -Name "mpv" –Force | Out-Null
Set-ItemProperty -Path "HKCR:\mpv" -Name "(Default)" -Value '"URL:mpv Protocol"' | Out-Null
Set-ItemProperty -Path "HKCR:\mpv" -Name "URL Protocol" -Value '""' | Out-Null
New-Item -Path "HKCR:\mpv" -Name "shell" –Force | Out-Null
New-Item -Path "HKCR:\mpv\shell" -Name "open" –Force | Out-Null
New-Item -Path "HKCR:\mpv\shell\open" -Name "command" –Force | Out-Null
Set-ItemProperty -Path "HKCR:\mpv\shell\open\command" -Name "(Default)" -Value  """$env:ProgramData\CTT\mpv-protocol\mpv-protocol-wrapper.cmd"" ""%1""" | Out-Null


"title MPV protocol handler -cl, originally for choco by bcurran3
set mpvprotocolURL=%1
set protocol=https://
set mpvprotocolURL=%protocol%%mpvprotocolURL:~14,-1%%
start mpv %mpvprotocolURL%&exit" | Set-Content $wrapperPath