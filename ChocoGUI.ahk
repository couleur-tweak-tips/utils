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
MSI AfterburnerplusK-Boost=0
NVIDIAProfileInspector=0

Gui, New
Gui, -MaximizeBox -MinimizeBox
gui, add ,button, x293 y360 h25, Installed Selected
Gui, add, checkbox, x10 y360 Disabled Checked, Chocolatey (Required)
Gui, add, Tab3, w380 h350 x10 y5, Essentials|Utilities|Media|Video|Games|Extras|Tweaks
Gui, Tab, 1
Gui, add, checkbox,, Google Chrome
Gui, add, checkbox,, 7-Zip
Gui, add, checkbox,, Everything
Gui, add, checkbox,, Paint.net
Gui, add, checkbox,, Discord

Gui, Tab, 2
Gui, add, checkbox,, EarTrumpet
Gui, add, checkbox,, VS Code
Gui, add, checkbox,, ShareX
Gui, add, checkbox,, WinDirStat
Gui, add, checkbox,, Notepad++
Gui, add, checkbox,, AutoHotkey
Gui, add, checkbox,, PowerToys

Gui, Tab, 3
Gui, add, checkbox,, VLC
Gui, add, checkbox,, MPV
Gui, add, checkbox,, Spotify

Gui, Tab, 4
Gui, add, checkbox,, FFmpeg
Gui, add, checkbox,, FFmpeg-Batch
Gui, add, checkbox,, OBS Studio

Gui, Tab, 5
Gui, add, checkbox,, Minecraft
Gui, add, checkbox,, Legendary
Gui, add, checkbox,, Steam

Gui, Tab, 6
Gui, add, checkbox,, Telegram
Gui, add, checkbox,, Element
Gui, add, checkbox,, TranslucentTB

Gui, Tab, 7
Gui, add, checkbox,, MSI Utility
Gui, add, checkbox,, MSI Afterburner + K-Boost
Gui, add, checkbox,, NVIDIA Profile Inspector

GuiControl, Focus, Button
Gui, Show, w400 h400

;Functions
GuiClose(){
	ExitApp
}
