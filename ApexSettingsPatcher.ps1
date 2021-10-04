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
$DriveLetter = $DriveLetter.ToUpper().replace('"','').SubString(0,$DriveLetter.IndexOf(':')).Replace(':','').Replace('\','').Replace('/','').Replace("`'",'')
Clear-Host
$Drive = "${DriveLetter}:\"
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
bind "F5" "fps_max 60" 0
bind "F6" "fps_max 0" 0
miles_channels 2
miles_occlusion 0
miles_occlusion_force 0
miles_occlusion_partial 0
sound_num_speakers 2
sound_without_focus 1
miles_occlusion_server_sounds_per_frame 200
snd_mixahead 0.05
snd_surround_speakers 2
snd_headphone_pan_exponent 2
snd_musicvolume 0
snd_setmixer PlayerFootsteps vol 0.1
snd_setmixer GlobalFootsteps vol 1.2
rope_wind_dist 4000
cl_footstep_event_max_dist 4000 
cl_footstep_event_max_dist 4000
telemetry_client_enable 0
telemetry_client_sendInterval 0
pin_opt_in 0
voice_forcemicrecord 0
mat_picmip 4
stream_memory "0"
mat_forceaniso 0
ssao_enabled 0
sssss_enable 0
particle_cpu_level 0
cl_ragdoll_maxcount 0
cl_particle_fallback_multiplier 4
cl_particle_fallback_base 4
noise_filter_scale 0
mat_bloom_scalefactor_scalar 0
mat_disable_bloom 1
nx_static_lobby_mode 2
cl_gib_allow 0
r_cleardecals
r_cheapwaterstart 0.000001
cl_forcepreload 1
mat_specular 0
mat_bumpmap 0
r_dynamic 0
shadow_enable 0
shadow_maxdynamic 0
shadow_max_dynamic 0
shadow_depth_dimen_min 0
shadow_depth_upres_factor_max 0
mat_mip_linear 0
staticProp_budget 1
staticProp_max_scaled_dist 250
func_break_max_pieces 1
cheap_captions_fadetime 0
cl_minimal_rtt_shadows 1' | Set-Content $ApexPath\cfg\autoexec.cfg
Set-ItemProperty -path $ApexPath\cfg\autoexec.cfg -name IsReadOnly $true

# ==================================== VideoConfig.txt ====================================

Remove-Item $videoconfig -Force -ErrorAction SilentlyContinue
'"VideoConfig"
{
    "setting.cl_gib_allow"		"0"
	"setting.cl_particle_fallback_base"		"1"
	"setting.cl_particle_fallback_multiplier"		"1"
	"setting.cl_ragdoll_maxcount"		"0"
	"setting.cl_ragdoll_self_collision"		"0"
	"setting.mat_forceaniso"		"1"
	"setting.mat_mip_linear"		"0"
	"setting.stream_memory"		"8000"
	"setting.mat_picmip"		"4"
	"setting.particle_cpu_level"		"0"
	"setting.r_createmodeldecals"		"0"
	"setting.r_decals"		"0"
	"setting.r_lod_switch_scale"		"0.1"
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
	"setting.gamma"		"0.7"
	"setting.configversion"		"7"
}' | Set-Content $videoconfig
Set-ItemProperty -path $videoconfig -name IsReadOnly $true
Write-Host end of file
pause;exit
