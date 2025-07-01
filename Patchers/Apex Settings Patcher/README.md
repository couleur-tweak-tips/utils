# Apex Settings Patcher

⚠️ 2023 WARNING: THIS IS A YEAR OLD AND THERES PROBABLY BETTER SETTINGS OUT THERE

PowerShell script to patch your Apex Legends settings (autoexec and videoconfig)

It starts by trying to find your Apex Legends path, then overwrites your existing settings and sets them as read-only


## Running it
Open Run (Windows+R) and paste this command in:
```powershell
powershell irm https://github.com/couleur-tweak-tips/utils/raw/main/Patchers/Apex%20Settings%20Patcher/Patcher.ps1 | iex
```

PowerShell script to patch your settings

⚠️ This will **overwrite** your current settings (autoexec & videoconfig) with these two files, understand you should back them up/tune them back
* autoexec.cfg <https://github.com/couleur-tweak-tips/utils/blob/main/Patchers/Apex%20Settings%20Patcher/autoexec.cfg>
* videoconfig.txt <https://github.com/couleur-tweak-tips/utils/blob/main/Patchers/Apex%20Settings%20Patcher/videoconfig.txt>

## **Running APS**
PowerShell is already installed by default on Windows, you can just open the Run dialog <:run:868538950313181274> (by pressing Windows +R) and paste this in:

```ps
powershell -noe iex(irm https://github.com/couleur-tweak-tips/utils/raw/main/Patchers/Apex%20Settings%20Patcher/Patcher.ps1)
```
If you're on a stripped/old Windows build and the one above failed, try this one, __open <:powershell:494601932871041024>  PowerShell for this one__
```ps
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://github.com/couleur-tweak-tips/utils/raw/main/Patchers/Apex%20Settings%20Patcher/Patcher.ps1'))
```
If you find settings that could be tuned better let me know
