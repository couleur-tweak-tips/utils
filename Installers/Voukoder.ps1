$Host.UI.RawUI.WindowTitle = "Voukoder Installer & Connector -couleur"
$connectors = @{ # Hashtable of all connectors, declared at the start of the script for easy acces))
    newveg =    "https://github.com/Vouk/voukoder-connectors/raw/master/vegas/vegas18-connector-1.2.0.msi"
    veg =       "https://github.com/Vouk/voukoder-connectors/raw/master/vegas/vegas-connector-1.5.0.msi"
    pp =        "https://github.com/Vouk/voukoder-connectors/raw/master/premiere/premiere-connector-1.10.0.msi"
    ae =        "https://github.com/Vouk/voukoder-connectors/raw/master/aftereffects/aftereffects-connector-0.10.0.msi"
    resolves =  "https://github.com/Vouk/voukoder-connectors/raw/master/resolve/resolve-connector-0.7.0.zip"
}

function DownloadFile ($URL,$Path){ # This is gonna get used a lot))
    Remove-Item  $Path -Force -ErrorAction Ignore
    (New-Object System.Net.WebClient).DownloadFile($URL, $Path)    
}

if (Test-Path "$env:ProgramFiles\Voukoder"){ # Voukoder check
    Write-Warning @"
WARNING: A voukoder installation was already found on your system

If you wish  to update Voukoder, uninstall the old one first
"@
    Start-Process ms-settings:appsfeatures
    pause
}

"Downloading & installing Voukoder Core.."
$download_url = (Invoke-RestMethod https://api.github.com/repos/Vouk/voukoder/releases/latest).assets.browser_download_url # Parses latest Voukoder release
$local_path = "$env:TEMP\VoukoderInstaller.msi"
DownloadFile $download_url $local_path
msiexec -i $local_path -Passive
Clear-Host
Write-Host "Voukoder Core successfully installed, continuing.."
timeout 1
Clear-Host
@'
Select which editing software connector youd like to download & install

Press N to connect it with VEGAS Pro 18-19
Press O to connect it with VEGAS Pro 12-17
Press P to connect it with Adobe Premiere CS6 + CC
Press A to connect it with Adobe AfterEffects
Press R to connect it with DaVinci Resolve
Press E to exit

(Windows Store VEGAS Pro versions are not supported)
'@
switch (choice.exe /C NOPARE /N | Out-Null) {

    1{ # VEGAS Pro 18-19
        DownloadFile $connectors.newveg "$env:TMP\NewVeg.msi" ; msiexec -i "$env:TMP\NewVeg.msi" -Passive
    }
    2{ # VEGAS Pro 12-17
        DownloadFile $connectors.veg "$env:TMP\Veg.msi" ; msiexec -i "$env:TMP\Veg.msi" -Passive
    }

    # No passive args for AE and PP, these seems to fuck up when installing, you gotta specify some folder in the install path (iirc \Common\Plug-ins\7.0\MediaCore)

    3{ # Adobe Premiere CS6 + CC
        DownloadFile $connectors.pp "$env:TMP\PP.msi" ; msiexec -i "$env:TMP\PP.msi"
    }
    4{ # Adobe AfterEffects
        DownloadFile $connectors.ae "$env:TMP\AE.msi" ; msiexec -i "$env:TMP\AE.msi"
    }
    5{ # DaVinci Resolve, opens in Explorer since this is a zip instead of an msi
        $Folder = "$env:TEMP\Resolve Connector"
        Remove-Item $Folder -Ea Ignore
        DownloadFile $connectors.resolves "$env:TMP\Resolve.zip" ; Expand-Archive "$env:TMP\Resolve.zip" $Folder
        Start-Process Explorer -ArgumentList $Folder
    }
    6{exit}
}