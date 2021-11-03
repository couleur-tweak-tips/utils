; BlurConfGUI by Aetopia
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force
#NoTrayIcon
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_APPDATA% ; Ensures a consistent starting directory.
IfNotExist, BlurConfig
	FileCreateDir, BlurConfig
IfNotExist, BlurConfig\blurconf-static.cfg
	FileCopy, C:\ProgramData\CTT\blurconf1\blurconf-static.cfg, BlurConfig\blurconf-static.cfg
for n, param in A_Args {
if (n=1){
VideoAHKFileName=%param%
Loop Files, %VideoAHKFileName%, F  ; Include files and directories.
        global VideoFileName := A_LoopFileFullPath
}
else{
MsgBox, 16, Error, Only one video file is allowed.
ExitApp
}
}
Gui, New
Gui, -MinimizeBox -MaximizeBox
Gui, Font, s10
Gui, Add, Button, gBlur w100 h50 x12 y5,Blur
Gui, Add, Button, gInterpolate w100 h50 x130 y5,Interpolate
Gui, Add, Button, gBlurPlusInterpolate w100 h50 x12 y60,Blur + Interpolate
Gui, Add, Button, gEdit w100 h50 x130 y60, Config
Gui, Font, s8
Gui, Show,, BlurConfGUI - Aetopia

Blur(){
Gui, +Disabled
FileReplaceLine("blur: true","BlurConfig\blurconf-static.cfg",2)
FileReplaceLine("interpolate: false","BlurConfig\blurconf-static.cfg",8)
Run, "C:\Program Files (x86)\blur\blur.exe" -i "%VideoFileName%" -c "BlurConfig\blurconf-static.cfg" -n
Process, WaitClose, blur.exe
MsgBox, 64, Finished, Blur finished., 2
ExitApp
}
Interpolate(){
Gui, +Disabled
FileReplaceLine("blur: false","BlurConfig\blurconf-static.cfg",2)
FileReplaceLine("interpolate: true","BlurConfig\blurconf-static.cfg",8)
Run, "C:\Program Files (x86)\blur\blur.exe" -i "%VideoFileName%" -c "BlurConfig\blurconf-static.cfg" -n
Process, WaitClose, blur.exe
MsgBox, 64, Finished, Interpolation finished., 2
ExitApp
}
BlurPlusInterpolate(){
Gui, +Disabled
FileReplaceLine("blur: true","BlurConfig\blurconf-static.cfg",2)
FileReplaceLine("interpolate: true","BlurConfig\blurconf-static.cfg",8)
Run, "C:\Program Files (x86)\blur\blur.exe" -i "%VideoFileName%" -c "BlurConfig\blurconf-static.cfg" -n
Process, WaitClose, blur.exe
MsgBox, 64, Finished, Blur + Interpolation finished., 2
}
Edit(){
Run, BlurConfig\blurconf-static.cfg
}

GuiClose(){
ExitApp
}

FileReplaceLine(InputVar, Filename, LineNum)
{
    tempfile = %A_Temp%\~FRL%A_TickCount%
    ; Open %filename% for input and %tempfile% for output:
    Loop, Read, %filename%, %tempfile%
    {
        ; If this line is not the target line, append it as is:
        if (A_Index != LineNum)
            FileAppend, %A_LoopReadLine%`n
        else ; append the replacement text:
            FileAppend, %InputVar%`n
    }
    ; Replace target file with temporary file:
    FileMove, %tempfile%, %filename%, 1
}
