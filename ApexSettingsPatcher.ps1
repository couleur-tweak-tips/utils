# Indicate a path that leads to r5apex.exe, if left as AutoDetect it will ask you to search per drive
$ApexPath = "AutoDetect"

# Change that if videoconfig is not in Saved Games (per example if your Windows' in a different lang)
$VideoConfig = "$home\Saved Games\Respawn\Apex\local\videoconfig.txt"


if ($ApexPath -eq "AutoDetect") {

$counts = GET-WMIOBJECT -query "SELECT * FROM Win32_DiskDrive"
$total_disk =  $counts.count
if ($total_disk -eq 1){$Drive = "C:\"}
else{
"
Which Drive is Apex Legends installed on?
"
$DriveLetter = Read-Host "(C:/,D:/,E:/ ect..)"
$DriveLetter = $DriveLetter -replace "[']",''
$DriveLetter = $DriveLetter -replace '["]',''
$DriveLetter = $DriveLetter -replace '[:]',''
$DriveLetter = $DriveLetter -replace '[/]',''
$Drive = "${DriveLetter}:/"
$drive
"Searching for Apex in $Drive.."
}
$ApexPath = Get-ChildItem -Path $Drive -Filter r5apex.exe -Recurse -ErrorAction SilentlyContinue | ForEach-Object{$_.FullName}
if (!$ApexPath) {Write-Host "r5apex.exe wasn't found, try again with another drive letter";timeout 3;exit}
"Apex found at path " + $ApexPath
}
$ApexPath = $ApexPath.Replace("'","")
$ApexPath = $ApexPath.Replace('"',"")
$ApexPath = $ApexPath.Substring(0,$ApexPath.Length-11)

# ==================================== autoexec.fg ========================================
Remove-Item $ApexPath\cfg\autoexec.cfg -Force -ErrorAction SilentlyContinue
'cl_fovScale 1.7
bind_US_standard "F12" "exec autoexec"

miles_occlusion_server_sounds_per_frame "200"
miles_occlusion "1"
miles_occlusion_force "0"
miles_occlusion_partial "0"
snd_mixahead "0.05"
snd_surround_speakers 2
snd_headphone_pan_exponent "2"
snd_muscivolume "0"
snd_setmixer PlayerFootsteps vol 0.1
snd_setmixer GlobalFootsteps vol 1.2
miles_channels 2' | Set-Content $ApexPath\cfg\autoexec.cfg
Set-ItemProperty -path $ApexPath\cfg\autoexec.cfg -name IsReadOnly $true

# ==================================== VideoConfig.txt ====================================

Remove-Item $videoconfig -Force -ErrorAction SilentlyContinue
'"VideoConfig"
{
    "setting.cl_gib_allow"		"0"
	"setting.cl_particle_fallback_base"		"3"
	"setting.cl_particle_fallback_multiplier"		"2"
	"setting.cl_ragdoll_maxcount"		"0"
	"setting.cl_ragdoll_self_collision"		"0"
	"setting.mat_forceaniso"		"1"
	"setting.mat_mip_linear"		"0"
	"setting.stream_memory"		"0"
	"setting.mat_picmip"		"2"
	"setting.particle_cpu_level"		"0"
	"setting.r_createmodeldecals"		"0"
	"setting.r_decals"		"0"
	"setting.r_lod_switch_scale"		"0.25"
	"setting.shadow_enable"		"0"
	"setting.shadow_depth_dimen_min"		"0"
	"setting.shadow_depth_upres_factor_max"		"0"
	"setting.shadow_maxdynamic"		"0"
	"setting.ssao_enabled"		"0"
	"setting.ssao_downsample"		"3"
	"setting.dvs_enable"		"0"
	"setting.dvs_gpuframetime_min"		"15000"
	"setting.dvs_gpuframetime_max"		"16500"
	"setting.defaultres"		"1920"
	"setting.defaultresheight"		"1080"
	"setting.fullscreen"		"1"
	"setting.nowindowborder"		"0"
	"setting.volumetric_lighting"		"0"
	"setting.mat_vsync_mode"		"0"
	"setting.mat_backbuffer_count"		"1"
	"setting.mat_antialias_mode"		"0"
	"setting.csm_enabled"		"0"
	"setting.csm_coverage"		"1"
	"setting.csm_cascade_res"		"512"
	"setting.fadeDistScale"		"1.000000"
	"setting.dvs_supersample_enable"		"0"
	"setting.gamma"		"0.635892"
	"setting.configversion"		"7"
}' | Set-Content $videoconfig
Set-ItemProperty -path $videoconfig -name IsReadOnly $true
Write-Host end of file
pause;exit
