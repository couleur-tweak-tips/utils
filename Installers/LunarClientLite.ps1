if ($Host.Name -match "ISE")
{
	Write-Warning "ISE isn't supported (use of choice.exe)"

	exit
}

$ErrorActionPreference = 'Inquire'
$WR = "$env:LOCALAPPDATA\Microsoft\WindowsApps"


Write-Output "Which version of LCL do you want?

Press E to get the compiled .EXE version - installs instantly, no need to install AutoHotkey, non modifiable
Press A to get the native .AHK version - readable and modifiable, needs AutoHotkey installed
Press U to uninstall LCL" 

function Remove-CurrentLCL
{
	Write-Output "Removing current installation of LCL.." 

	Stop-Process -Name LCL -Force -ErrorAction Ignore

	$Items = @(
        "$env:TEMP\Lunar Client Lite*",
        "$env:TEMP\LCL*",
		"$env:LOCALAPPDATA\Microsoft\WindowsApps\LCL*",
		"$env:LOCALAPPDATA\Microsoft\WindowsApps\config.ini",
		"$env:LOCALAPPDATA\Microsoft\WindowsApps\Resources",
		"$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Lunar Client Lite.lnk",
        "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Lunar Client Lite.lnk",
		"$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Lunar Client Lite.lnk"
	)
	Remove-Item -Path $Items -Recurse -Force -ErrorAction Ignore
}


$LCLver = (Invoke-RestMethod -Uri "https://api.github.com/repos/Aetopia/Lunar-Client-Lite-Launcher/releases/latest").tag_name
$Host.UI.RawUI.WindowTitle = "Lunar Client Lite $LCLver installer -couleur"
CHOICE /C EAU /N
# ----------------------------------------- .EXE --------------------------------
if ($LASTEXITCODE -eq 1){
	Remove-CurrentLCL

	$Parameters = @{
		Uri             = "https://api.github.com/repos/Aetopia/Lunar-Client-Lite-Launcher/releases/latest"
		UseBasicParsing = $true
	}
	$URL = (Invoke-RestMethod @Parameters).assets.browser_download_url

	$Parameters = @{
		Uri             = $URL
		OutFile         = "$env:LOCALAPPDATA\Microsoft\WindowsApps\LCL.exe"
		UseBasicParsing = $true
	}
	Invoke-WebRequest @Parameters

	$fileExt = '.exe'

	Unblock-File -Path "$env:LOCALAPPDATA\Microsoft\WindowsApps\LCL.exe"
}

#----------------------------------------- .AHK ----------------------------------
if ($LASTEXITCODE -eq 2){
	Remove-CurrentLCL

	$ahkAssoc = cmd /c assoc .ahk

	if (-not ($ahkAssoc -eq ".ahk=AutoHotkeyScript"))
	{
		if ($null -eq $env:ChocolateyInstall)
		{
			Clear-Host
			Write-Output "Installing Chocolatey.." 

			Start-Process -FilePath powershell -ArgumentList @(
				"Set-ExecutionPolicy -ExecutionPolicy Bypass -Force
				[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
				Invoke-RestMethod https://community.chocolatey.org/install.ps1 | Invoke-Expression"
			) -Verb RunAs -Wait

			Write-Output "Done!" 
		}

		Clear-Host

		Write-Output "Installing AutoHotkey.." 

		Start-Process -FilePath "$env:ProgramData\chocolatey\bin\cup.exe" -Argumentlist @("autohotkey", "-y") -Wait

		Write-Output "Done!" 
	}

	# # ------------------------------- INSTALLATION ------------------------------------
	$Items = @(
		"$env:TEMP\LCLite.zip",
		"$env:TEMP\LCLite",
		"$env:TEMP\Lunar-Client-Lite-Launcher-main"
	)
	Remove-Item -Path $Items -Recurse -Force -ErrorAction Ignore

	$Parameters = @{
		Uri             = "https://github.com/Aetopia/Lunar-Client-Lite-Launcher/archive/refs/heads/main.zip"
		OutFile         = "$env:TEMP\LCLSetup.zip"
		UseBasicParsing = $true
	}
	Invoke-WebRequest @Parameters

	$Parameters = @{
		Path            = "$env:TEMP\LCLSetup.zip"
		DestinationPath = "$env:TEMP"
		Force           = $true
	}
	Expand-Archive @Parameters

	if (Test-Path "$env:TEMP\Lunar-Client-Lite-Launcher-main\Logo.ico")
	{
		Move-Item -Path "$env:TEMP\Lunar-Client-Lite-Launcher-main\Logo.ico" -Destination "$env:TEMP\Lunar-Client-Lite-Launcher-main\Resources\Logo.ico"
	}
	Move-Item -Path "$env:TEMP\Lunar-Client-Lite-Launcher-main\Resources" -Destination "$WR" -Force
	Move-Item -Path "$env:TEMP\Lunar-Client-Lite-Launcher-main\LCL.ahk" -Destination "$WR" -Force

	$fileExt = '.ahk'

	$WshShell = New-Object -ComObject WScript.Shell
	$Shortcut = $WshShell.CreateShortcut("$WR\LCL.lnk")
	$Shortcut.IconLocation = "$WR\Resources\Logo.ico"
	$Shortcut.TargetPath = "$WR\LCL$fileExt"
	$Shortcut.Save()
}
#----------------------------------------- UNINSTALL -----------------------------
if ($LASTEXITCODE -eq 3){
	Remove-CurrentLCL
	exit
}

#----------------------------------------- SHORTCUTS -----------------------------

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Lunar Client Lite.lnk")
if ($fileExt -eq '.ahk')
{
	$Shortcut.IconLocation = "$WR\Resources\Logo.ico"
}
$Shortcut.TargetPath = "$WR\LCL$fileExt"
$Shortcut.Save()
Rename-Item -Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\lunar client lite.lnk" -NewName "Lunar Client Lite.lnk" -Force

$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Lunar Client Lite.lnk")
if ($fileExt -eq '.ahk')
{
	$Shortcut.IconLocation = "$WR\Resources\Logo.ico"
}
$Shortcut.TargetPath = "$WR\LCL$fileExt"
$Shortcut.Save()
Rename-Item -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\lunar client lite.lnk" -NewName "Lunar Client Lite.lnk" -Force

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Lunar Client Lite.lnk")
if ($fileExt -eq '.ahk')
{
	$Shortcut.IconLocation = "$WR\Resources\Logo.ico"
}
$Shortcut.TargetPath = "$WR\LCL$fileExt"
$Shortcut.Save()
Rename-Item -Path "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\lunar client lite.lnk" -NewName "Lunar Client Lite.lnk" -Force

#----------------------------------------- GRAALVM  -----------------------------
if (Test-Path "$env:ProgramData\GraalVM\bin\javaw.exe"){
Write-Output "GraalVM installation detected, setting up the settings.."
$MC = "$env:APPDATA\.minecraft"

"[LC]
Version=1.8
Arguments=-Xms3G -Xmx3G -XX:+DisableAttachMechanism -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M -XX:+EnableJVMCI -XX:+UseJVMCICompiler -XX:+EagerJVMCI -Djvmci.Compiler=graal
Cosmetics=1
Launcher_Version=2.8.4
[Minecraft]
AssetIndex=1.8
Assets=$MC\assets
JRE=$env:ProgramData\GraalVM\bin\javaw.exe
[Language]
Language=English
[Paths]
1.7_Dir=$MC
1.8_Dir=$MC
1.12_Dir=$MC
1.16_Dir=$MC
1.17_Dir=$MC" | Set-Content "$WR\config.ini"
}


Write-Output "`nInstallation finished!" 

if ($fileExt -eq '.exe')
{
	Write-Warning "`nIf execution fails due to Windows Defender false flagging it, consider getting the .AHK version"
}

Write-Output "Press any key to launch LCL and exit" 

while (-not [Console]::KeyAvailable)
{
	Start-Sleep -Milliseconds 15
}
if ($fileExt -eq '.exe'){$ExecExt = '.exe'}
if ($fileExt -eq '.ahk'){$ExecExt = '.lnk'}

Start-Process -FilePath powershell -WindowStyle Hidden -ArgumentList "$WR\LCL.$ExecExt"