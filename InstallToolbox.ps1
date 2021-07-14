#region
$host.ui.RawUI.WindowTitle = '/couleurm/couleurstoolbox install script'
function Set-ConsoleWindow
{
    param(
        [int]$Width= "75",
        [int]$Height= "10"
    )

    $WindowSize = $Host.UI.RawUI.WindowSize
    $WindowSize.Width  = [Math]::Min($Width, $Host.UI.RawUI.BufferSize.Width)
    $WindowSize.Height = $Height

    try{
        $Host.UI.RawUI.WindowSize = $WindowSize
    }
    catch [System.Management.Automation.SetValueInvocationException] {
        $Maxvalue = ($_.Exception.Message |Select-String "\d+").Matches[0].Value
        $WindowSize.Height = $Maxvalue
        $Host.UI.RawUI.WindowSize = $WindowSize
    }
}
Set-ConsoleWindow
#endregion

cls
Write-Host Removing the current toolbox
Remove-Item -Path "$env:homedrive$env:homepath\Desktop\couleurstoolbox" -Force -Recurse
Remove-Item -Path "$env:homedrive$env:homepath\Desktop\CTT Toolbox" -Force -Recurse
cls
Write-Host Downloading the latest version of the toolbox
Invoke-WebRequest -UseBasicParsing https://github.com/couleurm/couleurstoolbox/archive/refs/heads/main.zip -OutFile $env:TEMP\toolbox.zip

cls
Write-Host Unzipping..
Expand-Archive -LiteralPath $env:TEMP\toolbox.zip -DestinationPath "$env:homedrive$env:homepath\Desktop"

cls
Write-Host Renaming..
$ToolboxName='CTT Toolbox'
Rename-Item "$env:homedrive$env:homepath\Desktop\couleurstoolbox-main" "$env:homedrive$env:homepath\Desktop\$ToolboxName"

cls
write-Host Install done, opening the toolbox.
sleep 1

Start-Process "$env:homedrive$env:homepath\Desktop\$ToolboxName"
exit