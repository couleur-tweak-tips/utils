Try
{
	SetWorkingDir %A_ScriptDir%
	if not A_IsAdmin
		Run *RunAs "%A_ScriptFullPath%"
}
Catch, AdminFalse
{
	ExitApp
}
SetWorkingDir %A_ScriptDir%
#SingleInstance,Force
#NoTrayIcon
#NoEnv
;Variables
GoogleChrome=0
7Zip=0
Everything=0
Paintnet=0
Discord=0
EarTrumpet=0
VSCode=0
ShareX=0
WinDirStat=0
Notepadplusplus=0
AutoHotkey=0
PowerToys=0
VLC=0
MPV=0
Spotify=0
FFmpeg=0
FFmpegBatch=0
OBSStudio=0
Minecraft=0
Legendary=0
Steam=0
Telegram=0
Element=0
TranslucentTB=0
MSIUtility=0
MSIAfterburnerplusKBoost=0
NVIDIAProfileInspector=0

IfNotExist, C:\ProgramData\chocolatey\bin
	ChocoNotExist()
Gui, New
Gui, -MaximizeBox -MinimizeBox
Gui, add ,button, x293 y360 h25 gInstall, Installed Selected
Gui, add, button, x263 y360 h25 w25 gAbout, ?
Gui, add, Tab3, w380 h350 x10 y9, Essentials|Utilities|Media|Video|Games|Extras
Gui, Tab, 1
Gui, add, checkbox, vGoogleChrome, Google Chrome
Gui, add, checkbox, v7Zip, 7-Zip
Gui, add, checkbox, vEverything, Everything
Gui, add, checkbox, vPaintnet, Paint.net
Gui, add, checkbox, vDiscord, Discord

Gui, Tab, 2
Gui, add, checkbox, vEarTrumpet, EarTrumpet
Gui, add, checkbox, vVSCode, VS Code
Gui, add, checkbox, vShareX, ShareX
Gui, add, checkbox, vWinDirStat, WinDirStat
Gui, add, checkbox, vNotepadplusplus, Notepad++
Gui, add, checkbox, vAutoHotkey, AutoHotkey
Gui, add, checkbox, vPowerToys, PowerToys

Gui, Tab, 3
Gui, add, checkbox, vVLC, VLC
Gui, add, checkbox, vMPV, MPV
Gui, add, checkbox, vSpotify, Spotify

Gui, Tab, 4
Gui, add, checkbox, vFFmpeg, FFmpeg
Gui, add, checkbox, vFFmpegBatch, FFmpeg-Batch
Gui, add, checkbox, vOBSStudio, OBS Studio

Gui, Tab, 5
Gui, add, checkbox, vMinecraft, Minecraft
Gui, add, checkbox, vLegendary, Legendary
Gui, add, checkbox, vSteam, Steam

Gui, Tab, 6
Gui, add, checkbox, vTelegram, Telegram
Gui, add, checkbox, vElement, Element
Gui, add, checkbox, vTranslucentTB, TranslucentTB

;Gui, Tab, 7
;Gui, add, checkbox, vMSIUtility, MSI Utility
;Gui, add, checkbox, vMSIAfterburnerplusKBoost, MSI Afterburner + K-Boost
;Gui, add, checkbox, vNVIDIAProfileInspector, NVIDIA Profile Inspector

GuiControl, Focus, Button
Gui, Show, w400 h400, CTT Package Manager

;Functions
About(){
	Msgbox, 64, About, Based off the Chocolatey GUI made by Couleur.`nCTT Package Manager made by Couleur and Aetopia.
}

Install(){
	;-----------------------------------
	;Run, choco install %app% -y --force
	;Process, WaitClose, choco.exe
	;-----------------------------------
		GuiControlGet, GoogleChromeOutput,, GoogleChrome
		GuiControlGet, 7ZipOutput,, 7Zip
		GuiControlGet, EverythingOutput,, Everything
		GuiControlGet, PaintnetOutput,, Paintnet
		GuiControlGet, DiscordOutput,, Discord
		GuiControlGet, EarTrumpetOutput,, EarTrumpet
		GuiControlGet, VSCodeOutput,, VSCode
		GuiControlGet, ShareXOutput,, ShareX
		GuiControlGet, WinDirStatOutput,, WinDirStat
		GuiControlGet, NotepadplusplusOutput,, Notepadplusplus
		GuiControlGet, AutoHotkeyOutput,, AutoHotkey
		GuiControlGet, PowerToysOutput,, PowerToys
		GuiControlGet, VLCOutput,, VLC
		GuiControlGet, MPVOutput,, MPV
		GuiControlGet, SpotifyOutput,, Spotify
		GuiControlGet, FFmpegOutput,, FFmpeg
		GuiControlGet, FFmpegBatchOutput,, FFmpegBatch
		GuiControlGet, OBSStudioOutput,, OBSStudio
		GuiControlGet, MinecraftOutput,, Minecraft
		GuiControlGet, LegendaryOutput,, Legendary
		GuiControlGet, SteamOutput,, Steam
		GuiControlGet, TelegramOutput,, Telegram
		GuiControlGet, ElementOutput,, Element
		GuiControlGet, TranslucentTBOutput,, TranslucentTB
		GuiControlGet, MSIUtilityOutput,, MSIUtility
		GuiControlGet, MSIAfterburnerplusKBoostOutput,, MSIAfterburnerplusKBoost
		GuiControlGet, NVIDIAProfileInspectorOutput,, NVIDIAProfileInspector
		
	;Essentials
		If (GoogleChromeOutput=1){
			GoogleChrome=GoogleChrome
		}
		If (7ZipOutput=1){
			7Zip=7Zip
		}
		If (EverythingOutput=1){
			Everything=Everything
			
		}
		If (PaintnetOutput=1){
			Paintnet=Paint.net
		}
		If (DiscordOutput=1){
			Discord=Discord
		}
	;Utilities
		If (EarTrumpetOutput=1){
			EarTrumpet=EarTrumpet
		}
		If (VSCodeOutput=1){
			VSCode=VSCode
		}
		If (ShareXOutput=1){
			ShareX=ShareX
		}
		If (WinDirStatOutput=1){
			WinDirStat=WinDirStat
		}
		If (NotepadplusplusOutput=1){
			Notepadplusplus=Notepadplusplus
		}
		If (AutoHotkeyOutput=1){
			AutoHotkey=AutoHotkey
		}
		If (PowerToysOutput=1){
			PowerToys=PowerToys
		}
	;Media
		If (VLCOutput=1){
			VLC=VLC
		}
		If (MPVOutput=1){
			MPV=MPV
		}
		If (SpotifyOutput=1){
			Spotify=Spotify
		}
	;Video
		If (FFmpegOutput=1){
			FFMpeg=FFmpeg
		}
		If (FFmpegBatchOutput=1){
			FFMpegBatch=FFmpeg-Batch
		}
		If (OBSStudioOutput=1){
			OBSStudio=OBSStudio
		}
	;Games
		If (MinecraftOutput=1){
			Minecraft=Minecraft
		}
		If (LegendaryOutput=1){
			Legendary=Legendary
		}
		If (SteamOutput=1){
			Steam=Steam
		}
	;Extras
		If (TelegramOutput=1){
			Telegram=Telegram
		}
		If (ElementOutput=1){
			Element=Element
		}
		If (TranslucentTBOutput=1){
			TranslucentTB=TranslucentTB
		}
	;Tweaks
		;If (MSIUtilityOutput=1){
			;MsgBox MSI Utility: %MSIUtilityOutput%
		;}
		;If (MSIAfterburnerplusKBoostOutput=1){
			;MsgBox MSI Afterburner + KBoost: %MSIAfterburnerplusKBoostOutput%
		;}
		;If (NVIDIAProfileInspectorOutput=1){
			;MsgBox NVIDIA Profile Inspector: %NVIDIAProfileInspectorOutput%
		;}
		Run, choco install %GoogleChrome% %7Zip% %Everything% %Paintnet% %Discord% %EarTrumpet% %VSCode% %ShareX% %WinDirStat% %Notepadplusplus% %AutoHotkey% %PowerToys% %VLC% %MPV% %Spotify% %FFMpeg% %FFMpegBatch% %OBSStudio% %Minecraft% %Legendary% %Steam% %Telegram% %Element% %TranslucentTB%
		Process, WaitClose, choco.exe
		MsgBox, 64, Installed, Selected Packages are now installed.
		SetTitleMatchMode, 2
		#WinActivateForce
}

ChocoNotExist(){
	MsgBox, 16, Error, To use the CTT Package Manager, you need have Chocolatey installed.`nClick on OK to install Chocolatey.
	Run, "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')), Max
	Process, WaitClose, powershell.exe
	Run, choco feature enable -n allowGlobalConfirmation
	Process, WaitClose, choco.exe
	IfExist, C:\ProgramData\chocolatey\bin
		MsgBox, 64, Installed, Chocolatey is now installed.
}


GuiClose(){
	ExitApp
}
