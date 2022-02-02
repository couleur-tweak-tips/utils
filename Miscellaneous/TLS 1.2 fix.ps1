<#

This is a quick way to fix the "Could not create SSL/TLS secure channel" error for good when using Invoke-RestMethod (what is used to share scripts on CTT)

I see this occuring a lot among people running Windows version with old builds (e.g 1607 LTSB)

This will enable PowerShell's ExecutionPolicy (which is disabled per default) and might expose you to risks if you're the kinda guy that does not read what they run (I see you aren't)
it'll add a command that forces PowerShell to use TLS 1.2 everytime PowerShell is ran

If you ever see a command to run powershell that has the argument "-nop" or "-NoProfile", and what you're running does uses cmdlets like Invoke-RestMethod, you may want to remove that argument

#>

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Write-Warning "You need to run PowerShell as administrator in order for this script to modify your ExecutionPolicy."
    pause
    exit
}

if (-Not(Test-Path (Split-Path $PROFILE))){New-Item -ItemType Directory -Path (Split-Path $PROFILE) -Force}
if (-Not(Test-Path $PROFILE)){New-Item -Path $PROFILE -ItemType File -Force}
Get-Content $PROFILE | ForEach-Object {
    if ($_ -eq "[System.Net.ServicePointManager]::SecurityProtocol = 'Tls12'"){
        Write-Warning "TLS 1.2 patch already applied"
        pause
        exit
    }
}
Add-Content -Path $PROFILE -Value "[System.Net.ServicePointManager]::SecurityProtocol = 'Tls12'"
[System.Net.ServicePointManager]::SecurityProtocol = 'Tls12' # Also run it while we're at it
Set-ExecutionPolicy Unrestricted -Force # Forces so the user does not need to confirm, people already are on an older Windows build for a reason
Write-Warning "TLS 1.2 patch applied, restart other PowerShell sessions to apply it on every window (been applied to this one)"
pause
exit