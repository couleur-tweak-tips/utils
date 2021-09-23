Write-Host "Which version of LCL do you want?

Press E to get the compiled .EXE version (no need to install AutoHotkey, not modifiable)
Press A to press the .AHK version (modifiable, needs AutoHotkey installed)

Press Q to quit"
$WR = "$env:LOCALAPPDATA\Microsoft\WindowsApps"
$LCLver = (Invoke-RestMethod -Method GET -Uri "https://api.github.com/repos/Aetopia\Lunar-Client-Lite-Launcher/releases")[0].tag_name
$Host.UI.RawUI.WindowTitle = "Lunar Client Lite $LCLver installer -couleur"
$ErrorActionPreference = 'SilentlyContinue'
CHOICE /C EAQ /N
if ($LASTEXITCODE -eq 1){ # ----------------------------------------- .EXE --------------------------------
        Remove-Item "$WR\LCL.exe" -Force
        Remove-Item "$WR\LCL.ahk" -Force
        Remove-Item "$WR\config.ini" -Force
        Remove-Item "$WR\Resources" -Force -Recurse
        Remove-Item "$WR\LCL.lnk" -Force
        Remove-Item "$env:appdata\Microsoft\Windows\Start Menu\Programs\Lunar Client Lite.lnk" -Force
        Remove-Item "$env:appdata\Microsoft\Windows\Start Menu\Programs\Lunar Client Lite.lnk" -Force
        Remove-Item "$env:appdata\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Lunar Client Lite.lnk" -Force
        $source = ((Invoke-RestMethod -Method GET -Uri "https://api.github.com/repos/Aetopia\Lunar-Client-Lite-Launcher/releases")[0].assets | Where-Object name -like LCL.exe ).browser_download_url
        $destination = "$WR\LCL.exe"
        $webClient = [System.Net.WebClient]::new()
        $webClient.DownloadFile($source, $destination)
        $fileExt = '.exe'
    }
    if ($LASTEXITCODE -eq 2){ #----------------------------------------- .AHK -----------------------------------------
        Stop-Process -Name LCL
        Remove-Item "$WR\LCL.exe" -Force
        Remove-Item "$WR\LCL.ahk" -Force
        Remove-Item "$WR\config.ini" -Force
        Remove-Item "$WR\Resources" -Force -Recurse
        Remove-Item "$WR\LCL.lnk" -Force
        Remove-Item "$env:appdata\Microsoft\Windows\Start Menu\Programs\Lunar Client Lite.lnk" -Force
        Remove-Item "$env:appdata\Microsoft\Windows\Start Menu\Programs\Lunar Client Lite.lnk" -Force
        Remove-Item "$env:appdata\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Lunar Client Lite.lnk" -Force
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
        
if ($LASTEXITCODE -eq 3){exit}

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Lunar Client Lite.lnk")
if ($fileExt -eq '.ahk'){$Shortcut.IconLocation = "$WR\Resources\Logo.ico"}
$Shortcut.TargetPath = "$WR\LCL$fileExt"
$Shortcut.Save()

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:appdata\Microsoft\Windows\Start Menu\Programs\Lunar Client Lite.lnk")
if ($fileExt -eq '.ahk'){$Shortcut.IconLocation = "$WR\Resources\Logo.ico"}
$Shortcut.TargetPath = "$WR\LCL$fileExt"
$Shortcut.Save()

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:appdata\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Lunar Client Lite.lnk")
if ($fileExt -eq '.ahk'){$Shortcut.IconLocation = "$WR\Resources\Logo.ico"}
$Shortcut.TargetPath = "$WR\LCL$fileExt"
$Shortcut.Save()

Write-Host 'Installation finished!' -ForegroundColor Green

start-process powershell -WindowStyle Hidden -ArgumentList "$WR\LCL.lnk"
''
if ($fileExt -eq '.exe'){
Write-Warning 'If execution fails due to Windows Defender false flagging it, consider getting the .AHK version'
''
}
Write-Host 'Press any key to exit' -ForegroundColor DarkGray
While ( -not [Console]::KeyAvailable ) {Start-Sleep -Milliseconds 15}