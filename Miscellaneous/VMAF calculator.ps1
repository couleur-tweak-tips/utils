$ErrorActionPreference = 'Inquire'
$Location = Read-Host "Drag the master file, other samples must be in the same folder"
$Master = $Location.Replace('"','')
$Directory = $(Split-Path $Location).Replace('"','')
''
"Working in: $Directory"
Set-Location $Directory

$BaseName = ($(Get-Item $Master).BaseName)
$Time = $((Get-Date).DateTime)
Start-Transcript -Path ".\latest.txt"
''
#$Sample = Read-Host "How are your videos named? They must all have the same name, a space and a number after them, going from 1 to $Sample"

"Drag one video at a time and press enter each time, then type done once you're ready to start"

$Queue = [System.Collections.Arraylist]@()
[String]$Prompt = ''
while($Prompt -ne 'Done' -or $Prompt -eq ''){
    
    $Prompt = Read-Host 'Queue'
    if ($Prompt -ne 'Done'){$Queue.Add('"' + $Prompt.Replace('"','') + '"') | Out-Null}

}
"Queue:"
$Queue
''
if (-not(Test-Path ".\vmaf_v0.6.1.json"))
{
    "Downloading the VMAF JSON.."
    Invoke-WebRequest -UseBasicParsing https://cdn.discordapp.com/attachments/843853887847923722/900661998189154314/vmaf_v0.6.1.json -OutFile ".\vmaf_v0.6.1.json"
}
''
Start-Sleep 3

foreach($Video in $Queue)
{
    $command = "ffmpeg -hwaccel cuda -i $Master -hwaccel cuda -i " + $Video + " -filter_complex " + '[0:v:0][1:v:0]libvmaf=n_threads=16:model_path=vmaf_v0.6.1.json' + " -an -f null NUL"
    Write-Warning "Command: $command"
    Invoke-Expression $command
    Write-Output "Finished testing $Video"

}
Write-Warning 'Finished, press any key to exit'
pause
exit
