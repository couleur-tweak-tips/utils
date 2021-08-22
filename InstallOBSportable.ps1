$PortableDir = "$home\Documents\obs-portable-main"
$OBSpath = "$PortableDir\OBS"
$OBS64dir = "$OBSpath\bin\64bit"
$OBS64path = "$OBS64dir\obs64.exe"
$OBSprofilepath = "$OBSpath\config\obs-studio\basic\profiles"

$Zip = "$env:tmp\obs-portable.zip"
$SourceUri = "https://github.com/couleurm/obs-portable/archive/refs/heads/main.zip"
if (-not(Test-Path -Path $PortableDir)){
    Expand-Archive "$Zip" "$home\Documents" -ErrorAction SilentlyContinue
    if (-not(Test-Path $Zip)){
    $webClient = [System.Net.WebClient]::new()
    $webClient.DownloadFile($SourceUri, $Zip)
    Expand-Archive "$Zip" "$home\Documents"
    }
}
While(1){
Write-Output "Which kind of profile you want?

Press M for manual (tune it how you want it)
Press E to import an efficient 1080p60FPS profile for non-mc recordings
Press C for the settings I like using (1080p480 baseline)
Press F to finish when you've got the profiles you wanted (RECOMMENDED)"

choice /C MECF /N
if ($lastexitcode -eq "1") {
cls
Write-Host "OBS profile maker -coul"
Write-Host ''
Write-Host "What do you want your profile to be named?"
Write-Host ''
$ProfileName = Read-host ">"
mkdir "$OBSpath\config\obs-studio\basic\profiles\$ProfileName"
$CurrentProfilePath = "$OBSpath\config\obs-studio\basic\profiles\$ProfileName"
$recordEncoder = "$CurrentProfilePath\recordEncoder.json"
$basicini = "$CurrentProfilePath\basic.ini" # ----- Profile -------
cls
Write-Host "How long do you want your replay buffer to go back (in seconds)?"
Write-Host ''
$RecRBTime = Read-host ">"
cls
Write-Host "How much ram do you want replay buffer to allocate (in MBs)"
Write-Host ''
$RecRBSize = Read-host ">"
cls
Write-Host '' "What FPS do you want to record in?"
Write-Host ''
$FPSout = Read-host ">"
cls
Write-Host "What CQ level?"
Write-Host ''
Write-Host "Choose between 1 and 30, a good middleground is around 15"
Write-Host ''
$cqlevel = Read-host ">"
cls
Write-Host "What profile?"
Write-Host ''
Write-Host "Choose between high, main or baseline"
Write-Host "High is the most efficient but slower at a high FPS"
Write-Host "Baseline will give you the best performance at a high FPS but way larger files"
Write-Host "Main is a middleground between them"
Write-Host "Press H for High, M for Main, B for Baseline"
Write-Host ''
choice /c HBM /n
if ($LASTEXITCODE -eq 1) {$profile = "high"}
if ($LASTEXITCODE -eq 2) {$profile = "main"}
if ($LASTEXITCODE -eq 3) {$profile = "baseline"}
cls
Write-Host "What preset?"
Write-Host ""
Write-Host "Max Performance will make bigger files but you'll be able to record higher"
Write-Host "Max Quality will make much more efficient files but with less encoding performance"
Write-Host "Quality will be a bit less efficient while being faster"

Write-Host "Press P for Max Performance"
Write-Host "Press Q for Quality"
Write-Host "Press M for Max Quality"
choice /c PQM /n
if ($LASTEXITCODE -eq 1) {$preset = "hp"}
if ($LASTEXITCODE -eq 2) {$preset = "hq"}
if ($LASTEXITCODE -eq 3) {$preset = "mq"}
cls
Write-Host "Press 1 for 1080p, 7 for 720p, C for custom"
choice /C 17C /N
if ($LASTEXITCODE -eq "1"){ #1080p
    $height = "1080"
    $width = "1920"
    }
if ($LASTEXITCODE -eq "2"){ #720p
    $height = "720"
    $width = "1280"
    }
if ($LASTEXITCODE -eq "3"){ #Custom
    $height = Read-host "Height"
    $width = Read-Host "Width"
    }
}
if ($lastexitcode -eq "2"){
$profilename = "1080p60 - Effiency"
$width = "1920"
$height = "1080"
$FPSout = "60"
$RecRBTime = "12"
$RecRBSize = "2048"
$profile = "high"
$cqlevel = "15"
$preset = "mq"
$pvt = "true"
$lookahead = "true"
$bf = "4"
}
if ($lastexitcode -eq "3") {
$profilename = "Couleur - 1080p480"
$width = "1920"
$height = "1080"
$FPSout = "480"
$RecRBTime = "12"
$RecRBSize = "2048"
$profile = "baseline"
$cqlevel = "15"
$preset = "mp"
$pvt = "false"
$lookahead = "false"
$bf = "0"
}
if ($lastexitcode -eq "4") {
timeout 2
cd $obs64dir
Start-Process -FilePath "$OBS64path" -Verb RunAs -ArgumentList @('-p','--profile',"$ProfileName")
exit}
"[General]
Name=$profilename

[Video]
BaseCX=$width
BaseCY=$height
OutputCX=$width
OutputCY=$height
FPSType=2
FPSNum=$FPSout
ScaleType=bilinear
ColorSpace=709
AutoRemux=true

[Panels]
CookieId=1C677B938F9AA573

[Output]
Mode=Advanced
FilenameFormatting=%MM-%DD %hh-%mm

[AdvOut]
TrackIndex=1
RecType=Standard
RecFormat=mp4
RecEncoder=jim_nvenc
RecTracks=1
FLVTrack=1
FFOutputToFile=true
FFFormat=
FFFormatMimeType=
FFVEncoderId=0
FFVEncoder=
FFAEncoderId=0
FFAEncoder=
FFAudioMixes=1
RecRB=true
RecRBTime=$RecRBTime
RecRBSize=$RecRBSize

[SimpleOutput]
RecRBPrefix=R" |Set-Content $basicini
'{
    "bf": BFrames,
    "cqp": CQLevel,
    "lookahead": LookAheadCheck,
    "preset": "PresetLevel",
    "profile": "ProfileLevel",
    "psycho_aq": PVTCheck,
    "rate_control": "CQP"
}' | Set-Content "$CurrentProfilePath\recordEncoder.json"
(Get-Content -path $recordEncoder -Raw) -replace 'ProfileLevel',$profile | Set-Content $recordEncoder
(Get-Content -path $recordEncoder -Raw) -replace 'CQLevel',$cqlevel | Set-Content $recordEncoder
(Get-Content -path $recordEncoder -Raw) -replace 'PresetLevel',$preset | Set-Content $recordEncoder
(Get-Content -path $recordEncoder -Raw) -replace 'BFrames',$bf | Set-Content $recordEncoder
(Get-Content -path $recordEncoder -Raw) -replace 'LookAheadCheck',$lookahead | Set-Content $recordEncoder
(Get-Content -path $recordEncoder -Raw) -replace 'PVTCheck',$pvt | Set-Content $recordEncoder

cls;Write-Host "Profile imported"
}


