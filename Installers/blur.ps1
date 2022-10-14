Write-Warning "This installer is deprecated, use the official installer:"
"https://github.com/f0e/blur/releases/latest/download/blur-installer.exe"
return
exit
if (-Not (Get-Command scoop.ps1 -ErrorAction Ignore)){ # if scoop is not installed, install it
    
    [System.Net.ServicePointManager]::SecurityProtocol = 'Tls12' # Force TLS 1.2
    Set-ExecutionPolicy Bypass -Scope Process -Force # Bypass execution policy (scoop install requirement)
    Invoke-RestMethod https://get.scoop.sh | Invoke-Expression # Parse & invoke scoop install script
}

if (Get-Command blur-cli.exe -ErrorAction SilentlyContinue){ # if blur is already installed, warn user
    Write-Output @"
blur is already installed, press enter to continue

"@
pause
}

# Variables that will only trigger the if statement if they are valid
$utils = Convert-Path "$(((Get-Command scoop.cmd -Ea Ignore).Source))\..\..\buckets\utils" -ErrorAction Ignore
$git = Get-Command git.exe -ErrorAction Ignore

if ((-Not($utils)) -and $git){ # if git is installed, why not also add the bucket
    Write-Output "Installing the utils bucket (to keep blur updated)"
    scoop.cmd bucket add utils https://github.com/couleur-tweak-tips/utils
    scoop.cmd install utils/blur
}else{ # Else just throw in the raw URL
    scoop.cmd install https://github.com/couleur-tweak-tips/utils/raw/main/bucket/blur.json
}
