#region ------------------------------------- VARIABLES / USER FRIENDLY SECTION ----------------------
$Host.UI.RawUI.WindowTitle = "Customizable Launcher [cl v0.0.1] -couleur"
$MinecraftPath = "$home\AppData\Roaming\.minecraft"
$AmazonDomain = ".com"

$SearchEngine = "DuckDuckGo" # Available search engines: Google, DuckDuckGo, DuckDuckGoLite, BraveSearch, Qwant

$PreferedTextEditor = "PowerShellISE" #Available: NPP (aka Notepad++), PowershellISE, VSCode


# Google Translate config:
$langfrom = "en"
$langto = "it"
#endregion
$10 = $($args[10])
#region ------------------------------------- Websites -------------------------------------
if ( $($args[0]) -eq "s" -or $($args[0]) -eq 'se' -or $($args[0]) -eq "search"-or $($args[0]) -eq '$SearchEngine'){
if ($SearchEngine -ieq 'Google'){$SearchEngineURL = 'https://www.google.com/search?q='}
if ($SearchEngine -ieq 'DuckDuckGo'){$SearchEngineURL = 'https://www.duckduckgo.com/?t=ffab&q='}
if ($SearchEngine -ieq 'DuckDuckGoLite'){$SearchEngineURL = 'https://lite.duckduckgo.com/lite/?q='}
if ($SearchEngine -ieq 'Qwant'){$SearchEngineURL = 'https://www.qwant.com/?q='}
if ($SearchEngine -ieq 'Brave' -or $($args[0]) -eq 'BraveSearch'){$SearchEngineURL = 'https://search.brave.com/search?q='}
Write-Host "Looking up $($args[1]) $($args[1]) $($args[2]) $($args[3]) $($args[4]) $($args[5]) on $SearchEngine" -ForegroundColor Black -BackgroundColor White;timeout 1;Start-Process "$SearchEngineURL$($args[1])+$($args[2])+$($args[3])+$($args[4])+$($args[5])";exit}
if ($($args[0]) -eq 'ys' -or $($args[0]) -eq  'y'-or $($args[0]) -eq  'youtubesearch'){
Write-Host "Searching on YouTube $($args[1]) $($args[2]) $($args[3]) $($args[4]) $($args[5])" -ForegroundColor Black -BackgroundColor White; Start-Process https://www.youtube.com/results?search_query=$($args[1])+$($args[2])+$($args[3])+$($args[4])+$($args[5]);exit}
if ( $($args[0]) -eq 'yl' -or $($args[0]) -eq  'youtubelink'){
Write-Host "Opening YouTube link $($args[1])" -ForegroundColor Black -BackgroundColor White; Start-Process https://youtu.be/$($args[1]);exit}
if ( $($args[0]) -eq 'tw' -or $($args[0]) -eq  'twitter'){
Write-Host "Looking up $($args[1]) on Twitter" -ForegroundColor Black -BackgroundColor White; Start-Process https://twitter.com/$($args[1]);exit}
if ( $($args[0]) -eq 'tws' -or $($args[0]) -eq  'searchontwitter'){
Write-Host "Looking up $($args[1]) on Twitter" -ForegroundColor Black -BackgroundColor White; Start-Process "https://twitter.com/search?q=$($args[1]) $($args[2]) $($args[3]) $($args[4]) $($args[5])";exit}
if ( $($args[0]) -eq 'amz' -or $($args[0]) -eq  'amazon'){
Write-Host "Looking up $($args[1]) $($args[2]) $($args[3]) $($args[4]) $($args[5]) on Amazon" -ForegroundColor Black -BackgroundColor White; Start-Process https://www.amazon$AmazonDomain/s?k=$($args[1])+$($args[2])+$($args[3])+$($args[4])+$($args[5]);exit}
if ( $($args[0]) -eq 'wk' -or $($args[0]) -eq 'wikipedia' -or $($args[0]) -eq 'wiki'){
Write-Host "Looking up $($args[1]) $($args[1]) $($args[2]) $($args[3]) $($args[4]) $($args[5]) on Wikipedia" -ForegroundColor Black -BackgroundColor White; Start-Process https://en.wikipedia.org/wiki/Special:Search?search=$($args[1])+$($args[2])+$($args[3])+$($args[4])+$($args[5]);exit}
if ( $($args[0]) -eq 'n' -or $($args[0]) -eq 'namemc'){
Write-Host "Looking up $($args[1]) on NameMC" -ForegroundColor Black -BackgroundColor White; Start-Process https://mine.ly/$($args[1]);exit}
if ( $($args[0]) -eq 'gh' -or $($args[0]) -eq 'github'){
Write-Host "Looking up $($args[1]) on GitHub" -ForegroundColor Black -BackgroundColor White; Start-Process https://github.com/$($args[1]);exit}
if ( $($args[0]) -eq 'em' -or $($args[0]) -eq 'emoji' -or $($args[0]) -eq 'emojipedia'){
Write-Host "Looking up $($args[1]) $($args[2]) $($args[3]) $($args[4]) $($args[5]) on Emojipedia" -ForegroundColor Black -BackgroundColor White; Start-Process https://emojipedia.org/search/?q=$($args[1])+$($args[2])+$($args[3])+$($args[4])+$($args[5]);exit}
if ( $($args[0]) -eq "$langfrom$langto" -or $($args[0]) -eq '$langfrom-$langto'){
Write-Host "Translating from $langfrom to $langto.." -ForegroundColor Black -BackgroundColor White; Start-Process "https://translate.google.com/?sl=$langfrom&tl=$langto&text=$($args[1])+$($args[2])+$($args[3])+$($args[4])+$($args[5])";exit}
if ( $($args[0]) -eq "cs" -or $($args[0]) -eq 'chocosearch' -or $($args[0]) -eq 'choc'){
Write-Host "Searching in the Chocolatey Database.." -ForegroundColor Black -BackgroundColor White; Start-Process "https://community.chocolatey.org/packages?q=$($args[1])+$($args[2])+$($args[3])+$($args[4])+$($args[5])";exit}
#endregion
#region ------------------------------------- Folders / Programs ---------------------------
if ( $($args[0]) -eq 'mpv'){
if ((Test-Path -Path "$env:homedrive\mpv\mpv.exe" -PathType Leaf)){mpv $($args[1]);exit}
if ((Test-Path -Path "$env:homedrive\ProgramData\chocolatey\lib\mpv.install\tools\mpv.exe" -PathType Leaf)){mpv $($args[1]);exit}
if ((Test-Path -Path "$env:homedrive\ProgramData\chocolatey\bin\mpv.exe" -PathType Leaf)){mpv $($args[1]);exit}
mpv $($args[1]);exit}
if ( $($args[0]) -eq 'st' -or $($args[0]) -eq 'sendto'){
Start-Process $env:appdata\Microsoft\Windows\SendTo;exit}
if ( $($args[0]) -eq 'wr' -or $($args[0]) -eq 'windowsr' -or $($args[0]) -eq 'windowsapps'){
Start-Process $env:localappdata\Microsoft\WindowsApps;exit}
if ( $($args[0]) -eq 'v' -or $($args[0]) -eq 'videos'){
Start-Process $home\Videos;exit}
if ( $($args[0]) -eq 'c' -or $($args[0]) -eq 'cd' -or $($args[0]) -eq 'hd'-or $($args[0]) -eq 'homedrive'){
Start-Process $env:homedrive;exit}
if ( $($args[0]) -eq 'ps' -or $($args[0]) -eq 'powershell'){
Start-Process powershell -Verb RunAs;exit}
if ( $($args[0]) -eq 'cmd' -or $($args[0]) -eq 'cmda' -or $($args[0]) -eq 'cmdadmin'-or $($args[0]) -eq 'commandprompt'){
Start-Process $env:homedrive;exit}
if ( $($args[0]) -eq 'rp' -or $($args[0]) -eq 'packs'){
$MinecraftPath="$env:appdata\.minecraft"
start $MinecraftPath\resourcepacks;exit}
if ( $($args[0]) -eq 'sc' -or $($args[0]) -eq 'screenshots'){
$MinecraftPath="$env:appdata\.minecraft"
start $MinecraftPath\screenshots;exit}
if ( $($args[0]) -eq 'dl' -or $($args[0]) -eq 'downloads'){
start $home\Downloads;exit}
if ( $($args[0]) -eq 'e'-or $($args[0]) -eq 'edit'){
 # Text editor paths
$PowerShellISEPath = "$env:windir\system32\WindowsPowerShell\v1.0\PowerShell_ISE.exe"
$VSCodePath = "$env:ProgramFiles\Microsoft VS Code\Code.exe"
if (Test-Path "${env:ProgramFiles(x86)}\Notepad++\notepad++.exe"){$NPPPath = "${env:ProgramFiles(x86)}\Notepad++\notepad++.exe"}else{$NPPPath = "$env:ProgramFiles\Notepad++\notepad++.exe"}
# Checking if user specified a text editor before lauching
if ($($args[1]) -eq 'PSISE' -or $($args[1]) -eq 'ISE' -or $($args[1]) -eq 'PowerShellISE') {Start-Process "$PowerShellISEPath" $MyInvocation.InvocationName}
if ($($args[1]) -eq 'VSCode' -or $($args[1]) -eq 'Code') {Start-Process "$VSCodePath" $MyInvocation.InvocationName}
if ($($args[1]) -eq 'Notepad++' -or $($args[1]) -eq 'npp') {Start-Process "$NPPPath" $MyInvocation.InvocationName}
Exit
# Fallback to prefered text editor if user did not specify any
if ($PreferedTextEditor -eq 'PSISE' -or $PreferedTextEditor -eq 'ISE' -or $PreferedTextEditor -eq 'PowerShellISE') {$PreferedTextEditorPath = "$PowerShellISEPath"}
if ($PreferedTextEditor -eq 'VSCode' -or $PreferedTextEditor -eq 'Code') {$PreferedTextEditorPath = "$VSCodePath"}
if ($PreferedTextEditor -eq 'Notepad++' -or $PreferedTextEditor -eq 'npp') {$PreferedTextEditorPath = "$NPPPath"}
Start-Process $PreferedTextEditorPath $MyInvocation.InvocationName
Exit
}
if ( $($args[0]) -eq 'tb'-or $($args[0]) -eq 'tooblox'){
if (Test-Path "$home\Desktop\CTT Toolbox\") {Start-Process "$home\Desktop\CTT Toolbox\"}
iwr -useb "https://raw.githubusercontent.com/couleur-tweak-tips/utils/main/InstallToolbox.ps1" | iex
}
if ( $($args[0]) -eq 'ctt' -or $($args[0]) -eq 'couleurtweaktips'){
start discord:https://discord.com/channels/774315187183288411/813132439710466048}
if ( $($args[0]) -eq 'jctt' -or $($args[0]) -eq 'joinctt'){start https://dsc.gg/CTT;Exit}


#endregion
#region ------------------------------------- Install --------------------------------------
if ( $($args[0]) -eq 'Install' -or $($args[0]) -eq 'i'){

if ( $($args[1]) -eq 'DDU' -or $($args[1]) -eq 'DisplayDriverUninstaller'){
Remove-Item "$env:TEMP\DDU.zip" -ErrorAction SilentlyContinue -Recurse
Remove-Item "$env:TEMP\DisplayDriverUninstaller" -ErrorAction SilentlyContinue -Recurse
Remove-Item "$home\downloads\DDU" -ErrorAction SilentlyContinue -Recurse
$source = "https://ftp.nluug.nl/pub/games/PC/guru3d/ddu/[Guru3D.com]-DDU.zip"
$destination = "$env:TEMP\DDU.zip"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
Expand-Archive $destination $env:TEMP\DisplayDriverUninstaller
Start-Process "$env:TEMP\DisplayDriverUninstaller\DDU*.exe" -ArgumentList '-y' -Wait
cd "$env:TEMP\DisplayDriverUninstaller\DDU*.*.*"
Move-Item .\* -Destination "$home\downloads\DDU"
Start-Process "$home\downloads\DDU"
Exit}

if ( $($args[1]) -eq 'LCL' -or $($args[1]) -eq 'LCLite'){
$source = "https://github.com/Aetopia/Lunar-Client-Lite-Launcher/releases/latest/download/LCL.exe"
$destination = "$env:localappdata\Microsoft\WindowsApps\LCL.exe"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
Unblock-File $destination
Start-Process $destination
Exit}

if ( $($args[1]) -eq 'Heroic' -or $($args[1]) -eq 'HGL'){
Remove-Item "$env:TEMP\HeroicSetup.exe" -ErrorAction SilentlyContinue
$source = ((Invoke-RestMethod -Method GET -Uri https://api.github.com/repos/Heroic-Games-Launcher/HeroicGamesLauncher/releases/latest).assets | Where-Object name -like "Heroic.Setup.*" ).browser_download_url
$destination = "$env:TEMP\HeroicSetup.exe"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
Unblock-File $destination
Start-Process $destination
Exit}

if ( $($args[1]) -eq 'LunarClient' -or $($args[1]) -eq 'lc'){
$LunarVer = "v2.7.4"
$source = 'https://launcherupdates.lunarclientcdn.com/Lunar%20Client%20$LunarVer.exe'
$destination = "$env:TEMP\LunarClient.exe"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
Start-Process '$destination'
Exit}
if ( $($args[1]) -eq 'OBS25' -or $($args[1]) -eq 'OBS25.0.8' -or $($args[1]) -eq 'OBSold'){
$source = 'https://github.com/obsproject/obs-studio/releases/download/25.0.8/OBS-Studio-25.0.8-Full-Installer-x64.exe'
$destination = '$env:TEMP\OBSold.exe'
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
Start-Process '$destination'
Exit}
if ( $($args[1]) -eq 'npi' -or $($args[1]) -eq 'nvidiaProfileInspector'){
iwr  -useb 'https://github.com/Orbmu2k/nvidiaProfileInspector/releases/download/2.3.0.13/nvidiaProfileInspector.zip' -OutFile $env:Temp\nvidiaProfileInspector.zip
Expand-Archive -LiteralPath $env:Temp\nvidiaProfileInspector.zip -DestinationPath $env:homepath\Downloads\nvidiaProfileInspector\ -Force
iex $env:homepath\Downloads\nvidiaProfileInspector\nvidiaProfileInspector.exe}
# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}
    if (-not (Test-Path "$env:ProgramData\chocolatey\bin\choco.exe")){"Chocolatey installation not found!"
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }
choco feature enable -n allowGlobalConfirmation
choco install $($args[1]) $($args[2]) $($args[3]) $($args[4]) $($args[5]) $($args[6]) $($args[7]) $($args[8]) $($args[9]) $($args[10]) $($args[11]) $($args[12]) 
exit
}
if ( $($args[0]) -eq 'uninstall') {
# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}
if ( $($args[1]) -eq 'Edge' -or $($args[1]) -eq 'MicrosoftEdge' -or $($args[1]) -eq 'msedge') {

    Write-Host "Uninstalling Microsoft Edge may make some things unavailable/break certain features, please confirm to continue."
    pause

    Write-Progress "Stopping all potentially running instances of Edge"
    Stop-Process -Name msedge -Force -ErrorAction SilentlyContinue
    Stop-Process -Name msedge_proxy -Force -ErrorAction SilentlyContinue
    Stop-Process -Name mpwahelper -Force -ErrorAction SilentlyContinue
    Stop-Process -Name identity_helper -Force -ErrorAction SilentlyContinue
    Stop-Process -Name msedge -Force -PassThru -ErrorAction SilentlyContinue

    Write-Progress "Uninstalling Microsoft Edge"
    # Farag2's awesome version grabber https://habr.com/ru/news/t/515362/comments/#comment_21963136
    $ProductVersion = (Get-Item -Path ${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe).VersionInfo.ProductVersion
    Start-Process -FilePath ${env:ProgramFiles(x86)}\Microsoft\Edge\Application\$ProductVersion\Installer\setup.exe -ArgumentList "--uninstall --system-level --verbose-logging --force-uninstall"
    Write-Progress "Preventing it from coming back (DoNotUpdateToEdgeWithChromium)"
    Reg.exe add "HKLM\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d "1" /f
    Exit}

if ( $($args[1]) -eq 'OneDrive') {
# Source: Farag2's awesome SophiaScript: https://github.com/farag2/Sophia-Script-for-Windows/blob/faf7d337b3fa560fc78c50b8c75b36aeb5409954/Sophia/PowerShell%205.1/Module/Sophia.psm1#L3500
Write-Host "Uninstalling OneDrive may make some things unavailable/break certain features, please confirm to continue."
pause
    [string]$UninstallString = Get-Package -Name "Microsoft OneDrive" -ProviderName Programs -ErrorAction Ignore | ForEach-Object -Process {$_.Meta.Attributes["UninstallString"]}
    if ($UninstallString)
    {
        Write-Verbose -Message $Localization.OneDriveUninstalling -Verbose
        Stop-Process -Name OneDrive -Force -ErrorAction Ignore
        Stop-Process -Name OneDriveSetup -Force -ErrorAction Ignore
        Stop-Process -Name FileCoAuth -Force -ErrorAction Ignore
        # Getting link to the OneDriveSetup.exe and its' argument(s)
        [string[]]$OneDriveSetup = ($UninstallString -Replace("\s*/",",/")).Split(",").Trim()
        if ($OneDriveSetup.Count -eq 2)
        {
            Start-Process -FilePath $OneDriveSetup[0] -ArgumentList $OneDriveSetup[1..1] -Wait
        }
        else
        {
            Start-Process -FilePath $OneDriveSetup[0] -ArgumentList $OneDriveSetup[1..2] -Wait
        }
        # Get the OneDrive user folder path and remove it if it doesn't contain any user files
        if (Test-Path -Path $env:OneDrive)
        {
            if ((Get-ChildItem -Path $env:OneDrive -ErrorAction Ignore | Measure-Object).Count -eq 0)
        {
            Remove-Item -Path $env:OneDrive -Recurse -Force -ErrorAction Ignore

        # https://docs.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-movefileexa
        # The system does not move the file until the operating system is restarted
        # The system moves the file immediately after AUTOCHK is executed, but before creating any paging files

        $Signature = @{
        Namespace = "WinAPI"
        Name = "DeleteFiles"
        Language = "CSharp"
        MemberDefinition = @"

public enum MoveFileFlags
{
	MOVEFILE_DELAY_UNTIL_REBOOT = 0x00000004
}

[DllImport("kernel32.dll", SetLastError = true, CharSet = CharSet.Unicode)]
static extern bool MoveFileEx(string lpExistingFileName, string lpNewFileName, MoveFileFlags dwFlags);

public static bool MarkFileDelete (string sourcefile)
{
	return MoveFileEx(sourcefile, null, MoveFileFlags.MOVEFILE_DELAY_UNTIL_REBOOT);
}
"@
        }
        # If there are some files or folders left in %LOCALAPPDATA\Temp%
        if ((Get-ChildItem -Path $env:OneDrive -ErrorAction Ignore | Measure-Object).Count -ne 0)
        {
            if (-not ("WinAPI.DeleteFiles" -as [type]))
        {
            Add-Type @Signature
        }
        try
        {
        Remove-Item -Path $env:OneDrive -Recurse -Force -ErrorAction Stop
        }
        catch
            {
            # If files are in use remove them at the next boot
            Get-ChildItem -Path $env:OneDrive -Recurse -Force | ForEach-Object -Process {[WinAPI.DeleteFiles]::MarkFileDelete($_.FullName)}
            }
        }
        }
        else
            {
                # Invoke-Item doesn't work
                Start-Process -FilePath explorer -ArgumentList $env:OneDrive
			}
        }
        Remove-ItemProperty -Path HKCU:\Environment -Name OneDrive, OneDriveConsumer -Force -ErrorAction Ignore
        Remove-Item -Path HKCU:\SOFTWARE\Microsoft\OneDrive -Recurse -Force -ErrorAction Ignore
        Remove-Item -Path HKLM:\SOFTWARE\WOW6432Node\Microsoft\OneDrive -Recurse -Force -ErrorAction Ignore
        Remove-Item -Path "$env:ProgramData\Microsoft OneDrive" -Recurse -Force -ErrorAction Ignore
        Remove-Item -Path $env:SystemDrive\OneDriveTemp -Recurse -Force -ErrorAction Ignore
        Unregister-ScheduledTask -TaskName *OneDrive* -Confirm:$false

        # Getting the OneDrive folder path
        $OneDriveFolder = Split-Path -Path (Split-Path -Path $OneDriveSetup[0] -Parent)

        # Save all opened folders in order to restore them after File Explorer restarting
        Clear-Variable -Name OpenedFolders -Force -ErrorAction Ignore
        $OpenedFolders = {(New-Object -ComObject Shell.Application).Windows() | ForEach-Object -Process {$_.Document.Folder.Self.Path}}.Invoke()

        # Terminate the File Explorer process
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoRestartShell -Value 0 -Force
        Stop-Process -Name explorer -Force
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoRestartShell -Value 1 -Force
        # Attempt to unregister FileSyncShell64.dll and remove
        $FileSyncShell64dlls = Get-ChildItem -Path "$OneDriveFolder\*\amd64\FileSyncShell64.dll" -Force
            foreach ($FileSyncShell64dll in $FileSyncShell64dlls.FullName)
				{
					Start-Process -FilePath regsvr32.exe -ArgumentList "/u /s $FileSyncShell64dll" -Wait
					Remove-Item -Path $FileSyncShell64dll -Force -ErrorAction Ignore
					if (Test-Path -Path $FileSyncShell64dll)
					{
						if (-not ("WinAPI.DeleteFiles" -as [type]))
						{
							Add-Type @Signature
						}
						# If files are in use remove them at the next boot
						Get-ChildItem -Path $FileSyncShell64dll -Recurse -Force | ForEach-Object -Process {[WinAPI.DeleteFiles]::MarkFileDelete($_.FullName)}
					}
				}
        Start-Sleep -Seconds 1

        # Start the File Explorer process
        Start-Process -FilePath explorer

        # Restoring closed folders
        foreach ($OpenedFolder in $OpenedFolders)
                {
                    if (Test-Path -Path $OpenedFolder)
					{
						# Invoke-Item doesn't work
						Start-Process -FilePath explorer -ArgumentList $OpenedFolder
					}
				}

        Remove-Item -Path $OneDriveFolder -Recurse -Force -ErrorAction Ignore
        Remove-Item -Path $env:LOCALAPPDATA\OneDrive -Recurse -Force -ErrorAction Ignore
        Remove-Item -Path $env:LOCALAPPDATA\Microsoft\OneDrive -Recurse -Force -ErrorAction Ignore
        Remove-Item -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" -Force -ErrorAction Ignore
			}
        Exit
		}
}
#endregion
#region ------------------------------------- Other ----------------------------------------
if ( $($args[0]) -eq 'credits'){
@'
Credits to:

- rodli & fred for inspiring me
- Farag2 (SophiaScript creator) for motivation, advice & uninstall scripts
'@
pause
}
#endregion
#region ------------------------------------- Help / List ----------------------------------

cls;mode con cols=80 lines=50
$console = $host.ui.rawui
$console.backgroundcolor = "black"
$console.foregroundcolor = "white"
$art =@'



               ________/\\\\\\\\\__/\\\_____________        
                _____/\\\////////__\/\\\_____________       
                 ___/\\\/___________\/\\\_____________      
                  __/\\\_____________\/\\\_____________     
                   _\/\\\_____________\/\\\_____________    
                    _\//\\\____________\/\\\_____________   
                     __\///\\\__________\/\\\_____________  
                      ____\////\\\\\\\\\_\/\\\\\\\\\\\\\\\_ 
                       _______\/////////__\///////////////__



'@
$websitestolaunch =@"

    Available commands:

- Search engine (edit script to customize, DDG by default) - cl s <query>
- Edit the script - cl edit <NPP/VSCode/ise> or cl e <texteditor>
- Search on emojipedia - cl em <emoji>
- NameMC username or server - cl n/namemc <ign/ip> (Opens directly with mine.ly)
- Search on Amazon - cl amz <query> (Domain changeable via variable @ line 4)
- Search on Wikipedia -cl <wk <query>
- YouTube search or paste link (anti grabify) - cl ys/yl
- GitHub profile or repository - gh/github <user/repo>
- Chocolatey community package search - cl sc/chocosearch <packagequery>

- Play a video from URL - cl mpv <url/path>
- NvidiaProfileInspector, automatic download, extraction & execution - cl npi
- Debloat - cl uninstall MicrosoftEdge/OneDrive
- Open your Downloads/Videos folder - cl <v/dl>
- Open your .minecraft's resourcepacks/screenshots folder - cl rp/sc
- Open the Windows+R(WindowsApps)/SendTo folder - cl wr/st
- Open and/or download the CTT Toolbox - cl tb
- Get to the C:\ drive - cl <c/hd/homedrive>
- Update the toolbox - cl utb/tbu

- Install a package with Chocolatey (auto elevates) - cl i/install <package>
    + Lunar Client (lc,lunarclient) & OBS 25.0.8 (obs25,obs25.0.8,obsold)

"@
$art
Write-Host "     You added no arguments/no valid arguments. List of available commands:     " -BackgroundColor Red -ForegroundColor white
Write-Host $websitestolaunch

choice /C ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 /n /m ' '
exit
#endregion
<#egion ------------------------------------- COMMENTS -------------------------------------

$ScriptName= "[Regex]::Match( $MyInvocation.InvocationName, '[^\\]+\Z', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor [System.Text.RegularExpressions.RegexOptions]::SingleLine ).Value"

#>
$target="powershell.exe"
$targetArgs="-ExecutionPolicy bypass -NoExit -Command `"&'$home\Documents\Repos\utils\CustomizableLauncher.ps1'`""
$icon = "$env:TEMP\CLLogo.ico"

if (-not (Test-Path $env:localappdata\Microsoft\WindowsApps\cl.lnk -PathType Leaf)){

    if (-not (Test-Path $env:TEMP\CLLogo.ico -PahType Leaf)){
    $source = 
    $webClient = [System.Net.WebClient]::new()
    $webClient.DownloadFile($source, $icon)
    }


function Create-Shortcut($location, $target, $targetArgs, $boxstarterPath) {
    $wshshell = New-Object -ComObject WScript.Shell
    $lnk = $wshshell.CreateShortcut($location)
    $lnk.TargetPath = $target
    $lnk.Arguments = "$targetArgs"
    $lnk.WorkingDirectory = "$env:TEMP"
    $lnk.IconLocation=$icon
    $lnk.Save()
    }
 }