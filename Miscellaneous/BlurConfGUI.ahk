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
global Action = ""
for n, param in A_Args {
if (n=1){
VideoAHKFileName_1=%param%
Loop Files, %VideoAHKFileName_1%, F  ; Include files and directories.
        global VideoFileName_1 := A_LoopFileFullPath
}

else if (n=2){
VideoAHKFileName_2=%param%
Loop Files, %VideoAHKFileName_2%, F  ; Include files and directories.
        global VideoFileName_2 := A_LoopFileFullPath
}

else if (n=3){
VideoAHKFileName_3=%param%
Loop Files, %VideoAHKFileName_3%, F  ; Include files and directories.
        global VideoFileName_3 := A_LoopFileFullPath
}

else if (n=4){
VideoAHKFileName_4=%param%
Loop Files, %VideoAHKFileName_4%, F  ; Include files and directories.
        global VideoFileName_4 := A_LoopFileFullPath
}

else if (n=5){
VideoAHKFileName_5=%param%
Loop Files, %VideoAHKFileName_5%, F  ; Include files and directories.
        global VideoFileName_5 := A_LoopFileFullPath
}

else if (n=6){
VideoAHKFileName_6=%param%
Loop Files, %VideoAHKFileName_6%, F  ; Include files and directories.
        global VideoFileName_6 := A_LoopFileFullPath
}

else if (n=7){
VideoAHKFileName_7=%param%
Loop Files, %VideoAHKFileName_7%, F  ; Include files and directories.
        global VideoFileName_7 := A_LoopFileFullPath
}

else if (n=8){
VideoAHKFileName_8=%param%
Loop Files, %VideoAHKFileName_8%, F  ; Include files and directories.
        global VideoFileName_8 := A_LoopFileFullPath
}

else if (n=9){
VideoAHKFileName_9=%param%
Loop Files, %VideoAHKFileName_9%, F  ; Include files and directories.
        global VideoFileName_9 := A_LoopFileFullPath
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
FileReplaceLine("blur: true","BlurConfig\blurconf-static.cfg",2)
FileReplaceLine("interpolate: false","BlurConfig\blurconf-static.cfg",8)
Gui, Destroy
MsgBox, 64, BlurConfGUI - Aetopia, Queued Files:`n%VideoFileName_1%`n%VideoFileName_2%`n%VideoFileName_3%`n%VideoFileName_4%`n%VideoFileName_5%`n%VideoFileName_6%`n%VideoFileName_7%`n%VideoFileName_8%`n%VideoFileName_9%`nAction: Blur 
Run()
}
Interpolate(){
FileReplaceLine("blur: false","BlurConfig\blurconf-static.cfg",2)
FileReplaceLine("interpolate: true","BlurConfig\blurconf-static.cfg",8)
Gui, Destroy
MsgBox, 64, BlurConfGUI - Aetopia, Queued Files:`n%VideoFileName_1%`n%VideoFileName_2%`n%VideoFileName_3%`n%VideoFileName_4%`n%VideoFileName_5%`n%VideoFileName_6%`n%VideoFileName_7%`n%VideoFileName_8%`n%VideoFileName_9%`nSelected: Interpolation
Run()
}
BlurPlusInterpolate(){
FileReplaceLine("blur: true","BlurConfig\blurconf-static.cfg",2)
FileReplaceLine("interpolate: true","BlurConfig\blurconf-static.cfg",8)
Gui, Destroy
MsgBox, 64, BlurConfGUI - Aetopia, Queued Files:`n%VideoFileName_1%`n%VideoFileName_2%`n%VideoFileName_3%`n%VideoFileName_4%`n%VideoFileName_5%`n%VideoFileName_6%`n%VideoFileName_7%`n%VideoFileName_8%`n%VideoFileName_9%`nSelected: Blur + Interpolation
Run()
}
Edit(){
Run, BlurConfig\blurconf-static.cfg
}

Run(){
    If (VideoFileName_1 != ""){
        Run, "C:\Program Files (x86)\blur\blur.exe" -i "%VideoFileName_1%" -c "BlurConfig\blurconf-static.cfg" -n
    }

    If (VideoFileName_2 != ""){
        Process, WaitClose, blur.exe
        Run, "C:\Program Files (x86)\blur\blur.exe" -i "%VideoFileName_2%" -c "BlurConfig\blurconf-static.cfg" -n
    }

    If (VideoFileName_3 != ""){
        Process, WaitClose, blur.exe
        Run, "C:\Program Files (x86)\blur\blur.exe" -i "%VideoFileName_3%" -c "BlurConfig\blurconf-static.cfg" -n
    }

    If (VideoFileName_4 != ""){
        Process, WaitClose, blur.exe
        Run, "C:\Program Files (x86)\blur\blur.exe" -i "%VideoFileName_4%" -c "BlurConfig\blurconf-static.cfg" -n
    }

    If (VideoFileName_5 != ""){
        Process, WaitClose, blur.exe
        Run, "C:\Program Files (x86)\blur\blur.exe" -i "%VideoFileName_5%" -c "BlurConfig\blurconf-static.cfg" -n
    }

    If (VideoFileName_6 != ""){
        Process, WaitClose, blur.exe
        Run, "C:\Program Files (x86)\blur\blur.exe" -i "%VideoFileName_6%" -c "BlurConfig\blurconf-static.cfg" -n
    }

    If (VideoFileName_7 != ""){
        Process, WaitClose, blur.exe
        Run, "C:\Program Files (x86)\blur\blur.exe" -i "%VideoFileName_7%" -c "BlurConfig\blurconf-static.cfg" -n
    }

    If (VideoFileName_8 != ""){
        Process, WaitClose, blur.exe
        Run, "C:\Program Files (x86)\blur\blur.exe" -i "%VideoFileName_8%" -c "BlurConfig\blurconf-static.cfg" -n
    }

    If (VideoFileName_9 != ""){
        Process, WaitClose, blur.exe
        Run, "C:\Program Files (x86)\blur\blur.exe" -i "%VideoFileName_9%" -c "BlurConfig\blurconf-static.cfg" -n
    }
    Process, WaitClose, blur.exe
    MsgBox, 64, BlurConfGUI - Aetopia, Finished!
    ExitApp
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
