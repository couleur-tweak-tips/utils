#region ------------------------------------- VARIABLES / USER FRIENDLY SECTION ----------------------
$MinecraftPath = "$home\AppData\Roaming\.minecraft"
$AmazonDomain = ".com"
$SearchEngine = "DuckDuckGo" # Available search engines: Google, DuckDuckGo, DuckDuckGoLite, BraveSearch, Qwant
$PreferedTextEditor = "PowerShellISE" #Available: NPP (aka Notepad++), PowershellISE, VSCode

# Google Translate config:
$langfrom = "en"
$langto = "it"
#endregion
#region execution start
$Host.UI.RawUI.WindowTitle = "Customizable Launcher [cl v0.0.1] -couleur"
$1 = $($args[0])
$2 = $($args[1])
$3 = $($args[2])
$4 = $($args[3])
$5 = $($args[4])
$6 = $($args[5])
$7 = $($args[6])
$8 = $($args[8])
$9 = $($args[9])
$10 = $($args[10])
$11 = $($args[12])
$12 = $($args[13])
# $2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14+$15+$16
# $2 $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 $14 $15 $16
#endregion
#region ------------------------------------- Websites -------------------------------------
if ( $1 -eq "s" -or $1 -eq 'se' -or $1 -eq "search"-or $1 -eq '$SearchEngine'){
if ($SearchEngine -ieq 'Google'){$SearchEngineURL = 'https://www.google.com/search?q='}
if ($SearchEngine -ieq 'DuckDuckGo'){$SearchEngineURL = 'https://www.duckduckgo.com/?t=ffab&q='}
if ($SearchEngine -ieq 'DuckDuckGoLite'){$SearchEngineURL = 'https://lite.duckduckgo.com/lite/?q='}
if ($SearchEngine -ieq 'Qwant'){$SearchEngineURL = 'https://www.qwant.com/?q='}
if ($SearchEngine -ieq 'Brave' -or $1 -eq 'BraveSearch'){$SearchEngineURL = 'https://search.brave.com/search?q='}
Write-Host "Looking up $2 $2 $3 $4 $5 $6 on $SearchEngine" -ForegroundColor Black -BackgroundColor White;Start-Process "$SearchEngineURL$2+$3+$4+$5+$6";exit}
if ($1 -eq 'ys' -or $1 -eq  'y'-or $1 -eq  'youtubesearch'){
Write-Host "Searching on YouTube $2 $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 $14" -ForegroundColor Black -BackgroundColor White; Start-Process https://www.youtube.com/results?search_query=$2+$3+$4+$5+$6;exit}
if ( $1 -eq 'yl' -or $1 -eq  'youtubelink'){
Write-Host "Opening YouTube link $2" -ForegroundColor Black -BackgroundColor White; Start-Process https://youtu.be/$2;exit}
if ( $1 -eq 'tw' -or $1 -eq  'twitter'){
Write-Host "Looking up $2 on Twitter" -ForegroundColor Black -BackgroundColor White; Start-Process https://twitter.com/$2;exit}
if ( $1 -eq 'tws' -or $1 -eq  'searchontwitter'){
Write-Host "Looking up $2 on Twitter" -ForegroundColor Black -BackgroundColor White; Start-Process "https://twitter.com/search?q=$2 $3 $4 $5 $6 $7 $9 $10 $11 $12 $13";exit}
if ( $1 -eq 'amz' -or $1 -eq  'amazon'){
Write-Host "Looking up $2 $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 $14 on Amazon" -ForegroundColor Black -BackgroundColor White; Start-Process https://www.amazon$AmazonDomain/s?k=$2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14+$15+$16;exit}
if ( $1 -eq 'wk' -or $1 -eq 'wikipedia' -or $1 -eq 'wiki'){
Write-Host "Looking up $2 $2 $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 on Wikipedia" -ForegroundColor Black -BackgroundColor White; Start-Process https://en.wikipedia.org/wiki/Special:Search?search=$2+$3+$4+$5+$6;exit}
if ( $1 -eq 'n' -or $1 -eq 'namemc'){
Write-Host "Looking up $2 on NameMC" -ForegroundColor Black -BackgroundColor White; Start-Process https://mine.ly/$2;exit}
if ( $1 -eq 'gh' -or $1 -eq 'github'){
Write-Host "Looking up $2 on GitHub" -ForegroundColor Black -BackgroundColor White; Start-Process https://github.com/$2;exit}
if ( $1 -eq 'em' -or $1 -eq 'emoji' -or $1 -eq 'emojipedia'){
Write-Host "Looking up $2 $3 $4 $5 $6 on Emojipedia" -ForegroundColor Black -BackgroundColor White; Start-Process https://emojipedia.org/search/?q=$2+$3+$4+$5+$6;exit}
if ( $1 -eq "$langfrom$langto" -or $1 -eq '$langfrom-$langto'){
Write-Host "Translating from $langfrom to $langto.." -ForegroundColor Black -BackgroundColor White; Start-Process "https://translate.google.com/?sl=$langfrom&tl=$langto&text=$2+$3+$4+$5+$6";exit}
if ( $1 -eq "cs" -or $1 -eq 'chocosearch' -or $1 -eq 'choc'){
Write-Host "Searching in the Chocolatey Database.." -ForegroundColor Black -BackgroundColor White; Start-Process "https://community.chocolatey.org/packages?q=$2+$3+$4+$5+$6";exit}

if ( $1 -eq "MINOTAR" -or $1 -eq 'skin' -or $1 -eq 'mn'){
Start-Process "https://minotar.net/download/$2"
}

if ( $1 -eq "jds" -or $1 -eq 'joindiscordserver' -or $1 -eq 'joindc'){
Start-Process discord:$2
}
#endregion
#region ------------------------------------- Folders / Programs ---------------------------
if ( $1 -eq 'mpv'){
if ((Test-Path -Path "$env:homedrive\mpv\mpv.exe" -PathType Leaf)){mpv $2;exit}
if ((Test-Path -Path "$env:homedrive\ProgramData\chocolatey\lib\mpv.install\tools\mpv.exe" -PathType Leaf)){mpv $2;exit}
if ((Test-Path -Path "$env:homedrive\ProgramData\chocolatey\bin\mpv.exe" -PathType Leaf)){mpv $2;exit}
mpv $2;exit}
if ( $1 -eq 'st' -or $1 -eq 'sendto'){
Start-Process $env:appdata\Microsoft\Windows\SendTo;exit}
if ( $1 -eq 'wr' -or $1 -eq 'windowsr' -or $1 -eq 'windowsapps'){
Start-Process $env:localappdata\Microsoft\WindowsApps;exit}
if ( $1 -eq 'v' -or $1 -eq 'videos'){
Start-Process $home\Videos;exit}
if ( $1 -eq 'c' -or $1 -eq 'cd' -or $1 -eq 'hd'-or $1 -eq 'homedrive'){
Start-Process $env:homedrive;exit}
if ( $1 -eq 'ps' -or $1 -eq 'powershell'){
Start-Process powershell -Verb RunAs;exit}
if ( $1 -eq 'cmd' -or $1 -eq 'cmda' -or $1 -eq 'cmdadmin'-or $1 -eq 'commandprompt'){
Start-Process $env:homedrive;exit}
if ( $1 -eq 'rp' -or $1 -eq 'packs'){
$MinecraftPath="$env:appdata\.minecraft"
start $MinecraftPath\resourcepacks;exit}
if ( $1 -eq 'sc' -or $1 -eq 'screenshots'){
$MinecraftPath="$env:appdata\.minecraft"
start $MinecraftPath\screenshots;exit}
if ( $1 -eq 'dl' -or $1 -eq 'downloads'){
start $home\Downloads;exit}
if ( $1 -eq 'e'-or $1 -eq 'edit'){
 # Text editor paths
$PowerShellISEPath = "$env:windir\system32\WindowsPowerShell\v1.0\PowerShell_ISE.exe"
$VSCodePath = "$env:ProgramFiles\Microsoft VS Code\Code.exe"
if (Test-Path "${env:ProgramFiles(x86)}\Notepad++\notepad++.exe"){$NPPPath = "${env:ProgramFiles(x86)}\Notepad++\notepad++.exe"}else{$NPPPath = "$env:ProgramFiles\Notepad++\notepad++.exe"}
# Checking if user specified a text editor before lauching
if ($2 -eq 'PSISE' -or $2 -eq 'ISE' -or $2 -eq 'PowerShellISE') {Start-Process "$PowerShellISEPath" $MyInvocation.InvocationName}
if ($2 -eq 'VSCode' -or $2 -eq 'Code') {Start-Process "$VSCodePath" $MyInvocation.InvocationName}
if ($2 -eq 'Notepad++' -or $2 -eq 'npp') {Start-Process "$NPPPath" $MyInvocation.InvocationName}
Exit
# Fallback to prefered text editor if user did not specify any
if ($PreferedTextEditor -eq 'PSISE' -or $PreferedTextEditor -eq 'ISE' -or $PreferedTextEditor -eq 'PowerShellISE') {$PreferedTextEditorPath = "$PowerShellISEPath"}
if ($PreferedTextEditor -eq 'VSCode' -or $PreferedTextEditor -eq 'Code') {$PreferedTextEditorPath = "$VSCodePath"}
if ($PreferedTextEditor -eq 'Notepad++' -or $PreferedTextEditor -eq 'npp') {$PreferedTextEditorPath = "$NPPPath"}
Start-Process $PreferedTextEditorPath $MyInvocation.InvocationName
Exit
}
#endregion
#region ------------------------------------- Install --------------------------------------

if ($1 -eq 'ds' -or $1 -eq 'DownloadString'){
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}
iex ((New-Object System.Net.WebClient).DownloadString("$2"))
pause
exit}

if ($1 -eq 'christb' -or $1 -eq 'ChrisTitusTechToolbox'){
$source = "https://git.io/JJ8R4"
$destination = "$env:TEMP\christb.ps1"
Remove-Item $destination -Force -ErrorAction SilentlyContinue
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
 }
}
powershell.exe -file $destination -ExecutionPolicy Bypass -WindowStyle Hidden



pause
exit}

if ( $1 -eq 'Install' -or $1 -eq 'i'){
if ( $2 -eq 'DDU' -or $2 -eq 'DisplayDriverUninstaller'){
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
if ( $2 -eq 'NVC' -or $2 -eq 'NVCleanstall'){
Remove-Item "$home\Downloads\NVCleanstall.exe" -ErrorAction SilentlyContinue
# NVCleanstall can't be parsed sadly, gotta self-host via DiscordCDN.. sorry
# SHA256 for version 1.10.0 should be DBBA3DE024EC18D5D4E044990DB4F12B3BD4362791419471F1467CCF8243B11D
$NCver = "1.10.0"
$source = "https://cdn.discordapp.com/attachments/843853887847923722/870039242821234718/NVCleanstall_$NCver.exe"
$destination = "$home\Downloads\NVCleanstall.exe"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
Start-Process "$home\Downloads\"
Exit}
if ( $2 -eq 'LCL' -or $2 -eq 'LCLite'){
$source = "https://github.com/Aetopia/Lunar-Client-Lite-Launcher/releases/latest/download/LCL.exe"
$destination = "$env:localappdata\Microsoft\WindowsApps\LCL.exe"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
Unblock-File $destination
Start-Process $destination
Exit}
if ( $2 -eq 'Heroic' -or $2 -eq 'HGL'){
Remove-Item "$env:TEMP\HeroicSetup.exe" -ErrorAction SilentlyContinue
$source = ((Invoke-RestMethod -Method GET -Uri https://api.github.com/repos/Heroic-Games-Launcher/HeroicGamesLauncher/releases/latest).assets | Where-Object name -like "Heroic.Setup.*" ).browser_download_url
$destination = "$env:TEMP\HeroicSetup.exe"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
Unblock-File $destination
Start-Process $destination
Exit}
if ( $2 -eq 'LunarClient' -or $2 -eq 'lc'){
Remove-Item "$env:TEMP\LunarClient.exe" -ErrorAction SilentlyContinue
$ver = Invoke-RestMethod -Method GET -Uri "https://launcherupdates.lunarclientcdn.com/latest.yml"
$ver = $ver.Split([Environment]::NewLine) | Select -First 1
$ver = $ver.replace('version: ','')
echo "Installing LunarClient version $ver, please wait.."
$source = "https://launcherupdates.lunarclientcdn.com/Lunar%20Client%20v$ver.exe"
$destination = "$env:TEMP\LunarClient.exe"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
Start-Process "$destination" -wait
Remove-Item "$env:TEMP\LunarClient.exe" -ErrorAction SilentlyContinue
Exit}
if ( $2 -eq 'OBS' -or $2 -eq 'OBSnew' -or $2 -eq 'OBSlatest'){
"Write-Host Installing the latest release of OBS.."
Remove-item "$env:TMP\OBSnew.exe" -ErrorAction SilentlyContinue
$repo = "obsproject/obs-studio"
$filter = "OBS-Studio-*-Full-Installer-x64.exe"
$source = ((Invoke-RestMethod -Method GET -Uri https://api.github.com/repos/$repo/releases/latest).assets | Where-Object name -like "$filter" ).browser_download_url
$source
$destination = "$env:TMP\OBSnew.exe"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
start "$env:TMP\OBSnew.exe"
Exit}
if ( $2 -eq 'OBS25' -or $2 -eq 'OBS25.0.8' -or $2 -eq 'OBSold'){
cls;Write-Host "Downloading OBS 25.0.8"
$source = "https://github.com/obsproject/obs-studio/releases/download/25.0.8/OBS-Studio-25.0.8-Full-Installer-x64.exe"
$destination = "$env:TEMP\OBSold.exe"
$webClient = [System.Net.WebClient]::new()
$webClient.DownloadFile($source, $destination)
Start-Process "$destination"
Exit}
if ( $2 -eq 'npi' -or $2 -eq 'nvidiaProfileInspector'){
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
choco install $2 $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 $14 $15 -y
exit
}
if ( $1 -eq 'uninstall') {
# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}

if ( $2 -eq 'Edge' -or $2 -eq 'MicrosoftEdge' -or $2 -eq 'msedge') {

    Write-Host "Uninstalling Microsoft Edge may make some things unavailable/break certain features, please confirm to continue."
    pause

    Write-Progress "Stopping all potentially running instances Microsoft of Edge"
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

if ( $2 -eq 'OneDrive') {
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





if ( $1 -eq 'credits'){
@'
Credits to:

- rodli & fred for inspiring me
- Farag2 (SophiaScript creator) for motivation, advice & uninstall scripts
'@
pause
exit
}
if ( $1 -eq 'reinstalldrivers'){
$string = "https://raw.githubusercontent.com/couleur-tweak-tips/utils/main/reinstalldriver.ps1"
iex ((New-Object System.Net.WebClient).DownloadString("$string"))
exit}
if ( $1 -eq 'tb'-or $1 -eq 'toolbox'){
$string = "https://raw.githubusercontent.com/couleur-tweak-tips/utils/main/InstallToolbox.ps1"
iex ((New-Object System.Net.WebClient).DownloadString("$string"))
exit}
if ( $1 -eq 'ctt' -or $1 -eq 'couleurtweaktips'){
start discord:https://discord.com/channels/774315187183288411/813132439710466048
exit}
if ( $1 -eq 'contact' -or $1 -eq 'couleur'){
start discord:https://discord.com/users/352830597778898944
exit}
if ( $1 -eq 'jctt' -or $1 -eq 'joinctt'){
start https://dsc.gg/CTT
Exit}
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
- Search on YouTube - cl ys <query>
- Edit the script - cl edit <NPP/VSCode/ise> 
(default notepad strongly disrecommended)

- Search an emote on emojipedia - cl em <emoji>
- search a NameMC username or server - cl n/namemc <ign/ip>
- Search on Amazon - cl amz <query> (Domain changeable via variable @ line 4)
- Search on Wikipedia - cl <wk <query>
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

    Installable programs:
- Install a package with Chocolatey (auto elevates) - cl i/install <package>
Lunar Client - cl i <lc/lunarclient<
OBS 25.0.8 - cl i <obs25/obs25.0.8/obsold>

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