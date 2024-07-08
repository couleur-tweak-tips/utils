<# : batch portion
::mode con: lines=5
@echo off & (for %%I in (%*) do @echo(%%~I) | ^
PowerShell.exe -noexit -noprofile -command "$argv = $input | ?{$_}; iex (${%~f0} | out-string)"
exit /b
: end batch / begin powershell #>

$OUTPUT_FPS = 60

# $enc_args = "-vcodec h264_nvenc -profile:v high -preset fast -qmin 24 -qmax 24 -c:a copy";
$enc_args = "-c:v libx264 -tune fastdecode -preset veryfast -g 60 -x264-params bframes=0 -crf 20 -forced-idr 1 -strict -2 -maxrate 100M -bufsize 10M";


if ($isLinux -or $PSScriptRoot) {
	$argv = $args
}

$argv | ForEach-Object {
	
	$Metadata = ((ffprobe.exe -v quiet  -print_format json -show_format -show_streams -i $($_.trim())) | ConvertFrom-Json).Streams
	$VideoFPS = Invoke-Expression $($Metadata.avg_frame_rate | Select-Object -First 1) # Get object that contains FPS, then divides to real vlaue (e.g 120/2 or smth)

	$item = Get-Item $_
	$basename = $item.BaseName -replace "\.$"

	$Out = Join-Path $item.Directory.FullName ($basename + '-TMIX.MP4')
	$frames = $($VideoFPS / $OUTPUT_FPS)
	Write-Host "tmixing $basename`: $VideoFPS/$frames=$OUTPUT_FPS"

	$arguments = "ffmpeg -hide_banner -loglevel warning -stats -i `"$($item.FullName)`" $enc_args -vf tmix=frames=$frames`:weights=1 -r $OUTPUT_FPS -c:a copy $vf `"$Out`" -y"
	Invoke-Expression $arguments

	if ($LASTEXITCODE -ne 0) {
		''
		Write-Host 'Something went wrong, pausing..' -ForegroundColor Red
		''
		pause
	}
}
<#
for($i = 0; $i -lt @($argv).Length; $i++){


	Write-Host "temporally mixing $((Get-Item $argv[$i]).Name)"
	
	(ffprobe.exe -v quiet -print_format json -show_format -show_streams $argv[$i] | ConvertFrom-Json).Streams.avg_frame_rate | Where-Object { $_ -notlike "0/0" }
	
	
	#$Metadata = ((ffprobe.exe -v quiet -print_format json -show_format -show_streams `"$($argv[$i])`") | ConvertFrom-Json).Streams
	#$VideoFPS = $Metadata.avg_frame_rate | Select-Object -First 1
	#Write-Host $Metadata
	
	# 
}#>

exit

