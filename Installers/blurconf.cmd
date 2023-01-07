@echo off

:: ============== ::
:: == BLURCONF == ::
:: ============== ::

:: DO NOT TOUCH! Version for blurconf.
set version=1.1

:: Originally made by Couleur, rewritten by he3als for:
:: - easier installation
:: - unlimited multi-queuing of videos
:: - checks if there is an input, if blur exists, etc
:: - making the permenant config in the user's AppData

:: By default, config is located in %appdata%\BlurConf

:: GO CHECK OUT SMOOTHIE! It's Blur, but fully rewritten and better. :)
:: It already has the functionality of this script.

:: https://github.com/couleur-tweak-tips/Smoothie

:: Set to false if you do not want to see the message about not being installed into the 'Send To' folder
set installationPrompt=true

:: Set to false if you do not want to hear the notification sound when blur has completed
set notificationSound=true

:: You can change the executable where blur is located here
set "blurExe=%ProgramFiles(x86)%\blur\blur.exe"

:: --------------------------------- ::

title couleur's blurconf ^| rewritten by he3als ^| %version%

set "configPath=%appdata%\BlurConf\blurconf-static.cfg"
set videoCount=0

:: Check if blurconf is installed to AppData
if %installationPrompt%==false goto checks
echo "%~0" | find "%appdata%\Microsoft\Windows\SendTo" >nul 2>&1
if not %errorlevel%==0 goto install

:checks
if not exist "%blurExe%" (
	echo Blur is not found, please install it from the GitHub page.
	echo Alternatively, edit this script in 'shell:sendto' and change the blurExe variable to where blur is located.
	echo]
	echo Press any key to open the download to the latest version...
	explorer "https://github.com/f0e/blur/releases/latest/download/blur-installer.exe"
	exit /b 1
)

if "%~1"=="" (
	echo You need to give an input ^(at least one video^) to use this script.
	pause 
	exit /b 1
)

:blurConfigCheck
if exist "%configPath%" goto argsLoop
choice /c yn /n /m "A static blur config was not found! Would you like to make one? [Y/N] "
if %errorlevel%==1 goto blurConfigCreate
if %errorlevel%==2 (
	echo You need to manually create a file in this path and copy and paste a valid config into it:
	echo "%configPath%"
	echo]
	echo Alternatively, re-run this script and press 'y' on the option to make a default config.
	echo]
	echo Press any key to exit...
	pause > nul
	exit /b 1
)

:argsLoop
set input=%input% -i "%~1" -c %configPath%
set /a videoCount=%videoCount%+1
shift
if "%~1"=="" (goto main) else (goto argsLoop)

:main
mode con cols=78 lines=17
cls
echo                       __         __
echo                      / /___     / /  __     __   __    ____
echo                     / /___/_   / /  / /    / /  / /___/___/
echo                    / /   / /  / /  / /    / /  / _____/
echo                   / /___/_/  / /  / /____/ /  / /
echo                  /_/_/_/    /_/    /_____/   /_/
echo]
echo                              Queued %videocount% video/s...
echo]
echo  --------------------------------------------------------------------------- 
echo]
echo                                   [b]lur
echo                          [e]dit blurconf-static.cfg
echo                                extra [o]ptions
echo]
echo            Type one of the letters in brackets to select an option
choice /c beo /n
if %errorlevel%==1 (
	cls
	goto execution
)
if %errorlevel%==2 (notepad "%configPath%" & goto main)
if %errorlevel%==3 (goto options)

:execution
:: Set window size and buffer size
:: This is so that users can more easily see statistics about their video being blurred
powershell -noprofile -command "&{$w=(get-host).ui.rawui;$w.buffersize=@{width=120;height=9999};$w.windowsize=@{width=120;height=30};}"
echo Queued %videoCount% videos..
echo]
"%blurExe%" %input% -n
echo]
color 0a
echo Completed!
if %notificationSound%==true (call :notificationSound)
pause
exit /b 0

:options
mode con cols=78 lines=16
cls
echo                       __         __
echo                      / /___     / /  __     __   __    ____
echo                     / /___/_   / /  / /    / /  / /___/___/
echo                    / /   / /  / /  / /    / /  / _____/
echo                   / /___/_/  / /  / /____/ /  / /
echo                  /_/_/_/    /_/    /_____/   /_/
echo]
echo  --------------------------------------------------------------------------- 
echo]
echo                           Open blur's [d]irectory
echo                       Open blur's [G]itHub repository
echo                             [R]einstall blurconf                           
echo]
echo                           Go back to [m]ain menu
choice /c dgrm /n
if %errorlevel%==1 explorer "%ProgramFiles(x86)%\blur" & goto options
if %errorlevel%==2 explorer "https://github.com/f0e/blur" & goto options
if %errorlevel%==3 goto installConfirm
if %errorlevel%==4 goto main

:blurConfigCreate
cls
(
	echo - blur
	echo blur: true
	echo blur amount: 1
	echo blur output fps: 60
	echo blur weighting: equal
	echo]
	echo - interpolation
	echo interpolate: false
	echo interpolated fps: 480
	echo]
	echo - rendering
	echo quality: 18
	echo preview: false
	echo detailed filenames: false
	echo]
	echo - timescale
	echo input timescale: 1
	echo output timescale: 1
	echo adjust timescaled audio pitch: false
	echo]
	echo - filters
	echo brightness: 1
	echo saturation: 1
	echo contrast: 1
	echo]
	echo - advanced rendering
	echo gpu: false
	echo gpu type ^(nvidia/amd/intel^): nvidia
	echo deduplicate: true
	echo custom ffmpeg filters: -c:v libx264 -preset medium -crf 18 -aq-mode 3 -c:a copy
	echo]
	echo - advanced blur
	echo blur weighting gaussian std dev: 2
	echo blur weighting triangle reverse: false
	echo blur weighting bound: [0,2]
	echo]
	echo - advanced interpolation
	echo interpolation program ^(svp/rife/rife-ncnn^): svp
	echo interpolation speed: medium
	echo interpolation tuning: weak
	echo interpolation algorithm: 23
) >> "%configPath%"
echo Should be completed.
echo]
choice /c yn /n /m "Would you like to go the main menu? [Y/N] "
if %errorlevel%==1 goto argsLoop
if %errorlevel%==2 exit /b 0

:install
echo It seems like that blurconf is not being run from inside the current user's 'Send To' folder.
echo]
echo Send To is a feature where you can right click files and input the selected file(s) into a script or app.
echo It is in the right click context menu of File Explorer. Send To supports selecting multiple files.
echo]
echo blurconf is installed in this way.
echo]
echo NOTE: You can disable this prompt by setting 'installationPrompt' to false at the start of the script.
echo       Simply right click on the batch (.cmd) script, and click edit.
echo]
choice /c yn /n /m "Would you like to install blurconf to Send To? [Y/N] "
if %errorlevel%==1 goto installConfirm
if %errorlevel%==2 set installationPrompt=true & goto checks

:installConfirm
echo]
copy /y "%~0" "%appdata%\Microsoft\Windows\SendTo" > nul
color 0a
echo Completed, you can now use Send To for blurconf.
pause
exit /b 0

:notificationSound
where ffplay >nul 2>&1
if %errorlevel%==0 (
	if exist "C:\Windows\Media\tada.wav" (
		ffplay "C:\Windows\Media\tada.wav" -autoexit -showmode 0 -loglevel quiet
	)
)
exit /b 0