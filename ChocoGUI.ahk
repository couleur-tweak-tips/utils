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

Gui, New
Gui, -MaximizeBox -MinimizeBox
gui, add ,button, x293 y360 h25 gInstall, Installed Selected
Gui, add, button, x263 y360 h25 w25 gAbout, ?
Gui, add, checkbox, x10 y360 Disabled Checked, Chocolatey (Required)
Gui, add, Tab3, w380 h350 x10 y5, Essentials|Utilities|Media|Video|Games|Extras|Tweaks
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

Gui, Tab, 7
Gui, add, checkbox, vMSIUtility, MSI Utility
Gui, add, checkbox, vMSIAfterburnerplusKBoost, MSI Afterburner + K-Boost
Gui, add, checkbox, vNVIDIAProfileInspector, NVIDIA Profile Inspector

GuiControl, Focus, Button
Gui, Show, w400 h400, CTT Package Manager

;Functions
About(){
	Msgbox, 64, About, Based off the Chocolatey GUI made by Couleur.`nCTT Package Manager made by Couleur and Aetopia.
}

Install(){
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
		MsgBox Google Chrome: %GoogleChromeOutput%
	}
	If (7ZipOutput=1){
		MsgBox 7-Zip: %7ZipOutput%
	}
	If (EverythingOutput=1){
		MsgBox Everything: %EverythingOutput%
		
	}
	If (PaintnetOutput=1){
		MsgBox Paint.net: %PaintnetOutput%
	}
	If (DiscordOutput=1){
		MsgBox Discord: %DiscordOutput%
	}
	;Utilities
	If (EarTrumpetOutput=1){
		MsgBox EarTrumpet: %EarTrumpetOutput%
	}
	If (VSCodeOutput=1){
		MsgBox VS Code: %VSCodeOutput%
	}
	If (ShareXOutput=1){
		MsgBox ShareX: %ShareXOutput%
	}
	If (WinDirStatOutput=1){
		MsgBox WinDirStat: %WinDirStatOutput%
	}
	If (NotepadplusplusOutput=1){
		MsgBox Notepad++: %NotepadplusplusOutput%
	}
	If (AutoHotkeyOutput=1){
		MsgBox AutoHotkey: %AutoHotkeyOutput%
	}
	If (PowerToysOutput=1){
		MsgBox PowerToys: %PowerToysOutput%
	}
	;Media
	If (VLCOutput=1){
		MsgBox VLC: %VLCOutput%
	}
	If (MPVOutput=1){
		MsgBox MPV: %MPVOutput%
	}
	If (SpotifyOutput=1){
		MsgBox Spotify: %SpotifyOutput%
	}
	;Video
	If (FFmpegOutput=1){
		MsgBox FFMpeg: %FFmpegOutput%
	}
	If (FFmpegBatchOutput=1){
		MsgBox FFMpeg-Batch: %FFmpegBatchOutput%
	}
	If (OBSStudioOutput=1){
		MsgBox OBS Studio: %OBSStudioOutput%
	}
	;Games
	If (MinecraftOutput=1){
		MsgBox Minecraft: %MinecraftOutput%
	}
	If (LegendaryOutput=1){
		MsgBox Legendary: %LegendaryOutput%
	}
	If (SteamOutput=1){
		MsgBox Steam: %SteamOutput%
	}
	;Extras
	If (TelegramOutput=1){
		MsgBox Telegram: %TelegramOutput%
	}
	If (ElementOutput=1){
		MsgBox Element: %ElementOutput%
	}
	If (TranslucentTBOutput=1){
		MsgBox TranslucentTB: %TranslucentTBOutput%
	}
	;Tweaks
	If (MSIUtilityOutput=1){
		MsgBox MSI Utility: %MSIUtilityOutput%
	}
	If (MSIAfterburnerplusKBoostOutput=1){
		MsgBox MSI Afterburner + KBoost: %MSIAfterburnerplusKBoostOutput%
	}
	If (NVIDIAProfileInspectorOutput=1){
		MsgBox NVIDIA Profile Inspector: %NVIDIAProfileInspectorOutput%
	}
}

GuiClose(){
	ExitApp
}
