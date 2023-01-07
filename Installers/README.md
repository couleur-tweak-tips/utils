# ✨ PowerShell Installation Scripts
A bunch of small programs that I wanted to make easy to set up in a specific way. You can find guides using these scripts that go in depth on the [Couleur Tweak Tips Discord server](https://discord.com/invite/5gfkszbmuw)

```powershell
You can invoke them through Run (Windows+R):
powershell irm ctt.cx/cl | iex

Or inside of PowerShell itself:
Invoke-RestMethod ctt.cx/cl | Invoke-Expression
```
ctt.cx/ redirects to the raw URL of everything in this repository. As a note, blurconf has its own specific installation instructions below.

## <img src="https://i.imgur.com/Iul4mRT.png" alt="image.png" width="20" height="20"> ⠂[blurconf.cmd](https://github.com/couleur-tweak-tips/utils/blob/main/Installers/blurconf.cmd)
A batch script wrapper for [blur](https://github.com/f0e/blur), a free and open-source software for frame interpolation and motion blur (frame blending): fast, convenient to use and feature packed.

* Easy installation
* Unlimited multi-queuing of videos
* A static permenant config in the user's AppData, with improved defaults
* Integration with the Send To feature

Rewritten by [he3als](https://github.com/he3als) for extra features and fixes.

To install, run the below command in Command Prompt, PowerShell or Run (`Win` + `R`, recommended). Alternatively, directly [download](https://raw.githubusercontent.com/couleur-tweak-tips/utils/main/Installers/blurconf.cmd) the script and run it.

```powershell
powershell iwr "https://raw.githubusercontent.com/couleur-tweak-tips/utils/main/Installers/blurconf.cmd" -o "$ENV:appdata\Microsoft\Windows\SendTo\blurconf.cmd"
```
![](https://i.imgur.com/FGGA0Eh.png)

## <img src="https://i.imgur.com/VwfFfhF.png" alt="image.png" width="20" height="20"> ⠂[CustomizableLauncher.ps1](https://github.com/couleur-tweak-tips/utils/blob/main/Installers/CustomizableLauncher.ps1) (aka 'CL')
Automation at your fingertips, search through websites, run my scripts easily, everything from the Run window

* Install Chocolatey packages
* Search on sites (YouTube, DuckDuckGo, NameMC, GitHub, Twitter..)
* Run any scripts in utils (this repo)

![](https://i.imgur.com/oF7Euql.png)

## <img src="https://i.imgur.com/SBorklB.png" alt="image.png" width="20" height="20"> ⠂[Voukoder.ps1](https://github.com/couleur-tweak-tips/utils/blob/main/Installers/Voukoder.ps1)
Passively installs [Voukoder](https://voukoder.org), parses the releases and launches the connector with passive arguments
![](https://i.imgur.com/G7vaDTb.png)

## <img src="https://i.imgur.com/eBNJex3.png" alt="image.png" width="20" height="20"> ⠂[LunarClientLite.ps1](https://github.com/couleur-tweak-tips/utils/blob/main/Installers/LunarClientLite.ps1)

Installer for Aetopia's [Lunar Client Lite](https://github.com/Aetopia/Lunar-Client-Lite-Launcher), a fast, simple and unlocked launcher for Lunar Client, allowing you to have a custom JRE (wink wink GraalVM) and set directories by version.

![](https://i.imgur.com/vJo3bVs.png)

## <img src="https://i.imgur.com/o6HQ9fw.png" alt="image.png" width="20" height="20"> ⠂[GraalVM.ps1](https://github.com/couleur-tweak-tips/utils/blob/main/Installers/GraalVM.ps1)
Grabs some community edition builds from GraalVM and patches Lunar Client Lite with the correct settings.

Using GraalVM in Minecraft 1.8.9 significantly improves 0.2% lows from me and [Aetopia](https://github.com/Aetopia)'s testing
![](https://i.imgur.com/pmRz0KY.png)

## <img src="https://i.imgur.com/GsXyExR.png" alt="image.png" width="20" height="20"> ⠂[mpvProtocol.ps1](https://github.com/couleur-tweak-tips/utils/blob/main/Installers/mpvProtocol.ps1)
Adds a protocol handler so it opens [MPV](https://mpv.io/) when you click on mpv:// links, designed to help with non-embeddable Discord videos
```
To make mpv:// clickable on discord, type them like this:
<mpv://URL>
```

## <img src="https://i.imgur.com/gijdW5N.png" width="20" height="20"> ⠂[Nmkoder.ps1](https://github.com/couleur-tweak-tips/utils/blob/main/Installers/Nmkoder.ps1)
Installer & updater script for [Nmkoder](https://github.com/n00mkrad/nmkoder), a video encoding GUI
```
v1.4.0 is installed but v1.4.3 is out! Updating..
```

## <img src="https://i.imgur.com/63DbnAb.png" alt="image.png" width="20" height="20"> [Powercord.ps1](https://github.com/couleur-tweak-tips/utils/blob/main/Installers/Powercord.ps1)
Grabs all dependencies (DiscordCanary, Git, NodeJS) using [Scoop](https://scoop.sh) to [install Powercord](https://powercord.dev/installation) passively
