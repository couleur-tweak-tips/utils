Write-Host "Which version of LCL do you want?

Press E to get the compiled .EXE version - installs instantly, no need to install AutoHotkey, non modifiable
Press A to get the native .AHK version - readable and modifiable, needs AutoHotkey installed

Press U to uninstall LCL"
$WR = "$env:LOCALAPPDATA\Microsoft\WindowsApps"
$LCLver = (Invoke-RestMethod -Method GET -Uri "https://api.github.com/repos/Aetopia\Lunar-Client-Lite-Launcher/releases")[0].tag_name
$Host.UI.RawUI.WindowTitle = "Lunar Client Lite $LCLver installer -couleur"
$ErrorActionPreference = 'SilentlyContinue'
function Remove-CurrentLCL{
    Write-Host 'Removing current installation of LCL..' -ForegroundColor Red
    Stop-Process -Name LCL
    Remove-Item "$WR\LCL.exe" -Force
    Remove-Item "$WR\LCL.ahk" -Force
    Remove-Item "$WR\config.ini" -Force
    Remove-Item "$WR\Resources" -Force -Recurse
    Remove-Item "$WR\LCL.lnk" -Force
    Remove-Item "$env:appdata\Microsoft\Windows\Start Menu\Programs\Lunar Client Lite.lnk" -Force
    Remove-Item "$env:appdata\Microsoft\Windows\Start Menu\Programs\Lunar Client Lite.lnk" -Force
    Remove-Item "$env:appdata\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Lunar Client Lite.lnk" -Force
}

CHOICE /C EAU /N
if ($LASTEXITCODE -eq 1){ # ----------------------------------------- .EXE --------------------------------

        Remove-CurrentLCL
        $source = ((Invoke-RestMethod -Method GET -Uri "https://api.github.com/repos/Aetopia\Lunar-Client-Lite-Launcher/releases")[0].assets | Where-Object name -like 'LCL.exe').browser_download_url
        $webClient = [System.Net.WebClient]::new()
        $webClient.DownloadFile($source, "$WR\LCL.exe")
        $fileExt = '.exe'
    }
    if ($LASTEXITCODE -eq 2){ #----------------------------------------- .AHK -----------------------------------------

        Remove-CurrentLCL
        $ahkAssoc = cmd /c assoc .ahk
        if (!($ahkAssoc -eq '.ahk=AutoHotkeyScript')){
            if ($null -eq $env:ChocolateyInstall) {
                Clear-Host
                Write-Host 'Installing Chocolatey..' -ForegroundColor Green -NoNewline
                start-process powershell -verb runas -argumentlist "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" -wait
                Write-Host 'Done!' -ForegroundColor White

            }
                Clear-Host
                Write-Host 'Installing AutoHotkey..'  -ForegroundColor Green -NoNewline
                start-process "$env:ProgramData\chocolatey\bin\cup.exe" -argumentlist 'autohotkey -y' -Wait
                Write-Host 'Done!' -ForegroundColor White
        }
            # # ------------------------------- INSTALLATION ------------------------------------

            Remove-Item "$env:TMP\LCLite.zip" -ErrorAction Ignore
            Remove-Item "$env:TMP\LCLite\" -Recurse -ErrorAction Ignore
            Remove-Item "$env:TMP\Lunar-Client-Lite-Launcher-main" -Recurse -ErrorAction Ignore

            $source = 'https://github.com/Aetopia/Lunar-Client-Lite-Launcher/archive/refs/heads/main.zip'
            $destination = "$env:TMP\LCLSetup.zip"
            $webClient = [System.Net.WebClient]::new()
            $webClient.DownloadFile($source, $destination)
            
            Expand-Archive $destination "$env:TMP"
            if (Test-Path "$env:TEMP\Lunar-Client-Lite-Launcher-main\Logo.ico"){Move-Item -Path "$env:TEMP\Lunar-Client-Lite-Launcher-main\Logo.ico" "$env:TEMP\Lunar-Client-Lite-Launcher-main\Resources\Logo.ico"}
            Move-Item "$env:TMP\Lunar-Client-Lite-Launcher-main\Resources" "$WR"
            Move-Item "$env:TMP\Lunar-Client-Lite-Launcher-main\LCL.ahk" "$WR"

            $fileExt = '.ahk'

            $WshShell = New-Object -comObject WScript.Shell
            $Shortcut = $WshShell.CreateShortcut("$WR\LCL.lnk")
            $Shortcut.IconLocation = "$WR\Resources\Logo.ico"
            $Shortcut.TargetPath = "$WR\LCL$fileExt"
            $Shortcut.Save()
        }
        
if ($LASTEXITCODE -eq 3){Remove-CurrentLCL;exit}

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Lunar Client Lite.lnk")
if ($fileExt -eq '.ahk'){$Shortcut.IconLocation = "$WR\Resources\Logo.ico"}
$Shortcut.TargetPath = "$WR\LCL$fileExt"
$Shortcut.Save()
Rename-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\lunar client lite.lnk" "Lunar Client Lite.lnk"

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:appdata\Microsoft\Windows\Start Menu\Programs\Lunar Client Lite.lnk")
if ($fileExt -eq '.ahk'){$Shortcut.IconLocation = "$WR\Resources\Logo.ico"}
$Shortcut.TargetPath = "$WR\LCL$fileExt"
$Shortcut.Save()
Rename-Item "$env:appdata\Microsoft\Windows\Start Menu\Programs\lunar client lite.lnk" "Lunar Client Lite.lnk"

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:appdata\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Lunar Client Lite.lnk")
if ($fileExt -eq '.ahk'){$Shortcut.IconLocation = "$WR\Resources\Logo.ico"}
$Shortcut.TargetPath = "$WR\LCL$fileExt"
$Shortcut.Save()
Rename-Item "$env:appdata\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\lunar client lite.lnk" "Lunar Client Lite.lnk"

Write-Host 'Installation finished!' -ForegroundColor Green
''
if ($fileExt -eq '.exe'){
    Write-Warning 'If execution fails due to Windows Defender false flagging it, consider getting the .AHK version'
    ''
}
Write-Host 'Press any key to launch LCL and exit' -ForegroundColor DarkGray
While ( -not [Console]::KeyAvailable ) {Start-Sleep -Milliseconds 15}
if ($fileExt -eq '.exe'){$ExecExt = '.exe'}
if ($fileExt -eq '.ahk'){$ExecExt = '.lnk'}
Start-Process powershell -WindowStyle Hidden -ArgumentList "$WR\LCL.$ExecExt"