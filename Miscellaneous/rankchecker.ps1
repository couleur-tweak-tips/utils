function rankchecker {
[CmdletBinding()]param(
    [Parameter(ValueFromRemainingArguments = $true)][String]$accargs
)

    function Write-Color {

        [CmdletBinding()]param(
            [Parameter(ValueFromRemainingArguments = $true)][String]$Queue
        )
        
        ForEach($Color in [Enum]::GetValues([ConsoleColor])){
        
            # Setting up the splatting 
            Set-Variable -Name $Color -Value @{ForegroundColor = "$Color"} -Force -ErrorAction Inquire
            Set-Variable -Name "bg$Color" -Value @{BackgroundColor = "$Color"} -Force -ErrorAction Inquire
        
        }
        
        ForEach($Message in $Queue -Split " '"){
        
            if ($Message[0] -ne "'"){$Message = "'" + $Message}
        
            Invoke-Expression "Write-Host $Message -NoNewLine"
           
        }
        ''
        }
    
    function CheckLunar ($IGN) {
        Try {
            $Response = (Invoke-RestMethod https://lunar.gg/u/$IGN -ErrorAction Stop) -Split '\r?\n' 
        } Catch {
            Write-Host "`rNone (Parsing failed / Never joined)" -ForegroundColor DarkGray
            return $null
        }
        $Count = 0
        $Line = ''
        While ($Line -notlike "*premium-box*"){
            $Line = $Response[$Count]
            $Count++
        }
        $Rank = $Response[$Count+2].Trim()
        switch ($Rank){
            'Owner' {$RankColor = @{ForegroundColor = 'DarkRed'}}
            'YouTuber' {$RankColor = @{ForegroundColor = 'Red'}}
            'King' {$RankColor = @{ForegroundColor = 'DarkGreen'}}
            'Master' {$RankColor = @{ForegroundColor = 'Yellow'}}
            'Basic' {$RankColor = @{ForegroundColor = 'White'}}
            'Default' {$RankColor = @{ForegroundColor = 'DarkGray'}}
        }
        Write-Host "`r$Rank                 " @RankColor
    }
    
    function CheckPlancke ($IGN) {
        Try {
            $Response = (Invoke-RestMethod https://plancke.io/hypixel/player/stats/$IGN) -Split '\r?\n'
        } Catch {
            Write-Host "`rNone (Parsing failed / Never joined)" -ForegroundColor DarkGray
            return $null
        }
    
        $Line = $Response | Where-Object {$_ -Like "*og:description*"}
        $Line = $Line -Split '<meta property="og:description" content="'
        $Line = $Line -Split '" /><meta property='
        $Title = $Line[5].Trim()
        switch ($Title){
            {$_ -Like '`[VIP*`]*'} {$RankColor = @{ForegroundColor = 'Green'}}
            {$_ -Like '`[MVP*`]*'} {$RankColor = @{ForegroundColor = 'Cyan'}}
            {$_ -Like '`[YOUTUBE]*'} {$RankColor = @{ForegroundColor = 'Red'}}
            {$_ -NotLike '`[*`]*'}{$RankColor = @{ForegroundColor = 'DarkGray'};$Rank = 'Default'}
            Default {$RankColor = @{ForegroundColor = 'DarkGray'}}
        }
    
        Write-Host "`r$Title                 " @RankColor
    }

    function CheckMMC ($IGN){
        Try {
            $Response = curl.exe -s "https://minemen.club/player/$IGN" -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0'
        } Catch {
            Write-Host "`rNone (Parsing failed / Never joined)" -ForegroundColor DarkGray
            return $null
        }
        $Rank = $Response -Split '\r?\n' | Where-Object {$PSItem -Like "*<span class=`"player-info-rank*"}
        $Rank = ($Rank -Split '">' -Split '</span>')[1]
        switch ($Rank){
            'Owner' {$RankColor = @{ForegroundColor = 'DarkRed'}}
            'Media' {$RankColor = @{ForegroundColor = 'DarkBlue'}}
            'Partner' {$RankColor = @{ForegroundColor = 'Magenta'}}
            'Famous' {$RankColor = @{ForegroundColor = 'Orange'}}
            'Clubber' {$RankColor = @{ForegroundColor = 'DarkGreen'}}
            'Raver' {$RankColor = @{ForegroundColor = 'Pink'}}
            'Bartender' {$RankColor = @{ForegroundColor = 'Cyan'}}
            'Bouncer' {$RankColor = @{ForegroundColor = 'Cyan'}}
            'Default' {$RankColor = @{ForegroundColor = 'DarkGray'}}
        }

        Write-Host "`r$Rank                 " @RankColor

    }

    function CheckManaCube ($UUID){
        $UUID = [System.Guid]::Parse($UUID)
        $Rank = (Invoke-RestMethod https://manacube.com/stats_data/fetch.php?uuid=$UUID).rank
        $Rank = $Rank.ToUpper()
        Write-Host "`r$Rank                                   "
    }
    
    if ($accargs -eq '-'){
        $Arguments = (Get-Clipboard) -Split '\r?\n'
    }else{
        $Arguments = $accargs
    }
    ForEach($Account in $Arguments){

        $UUID = (Invoke-RestMethod https://api.mojang.com/user/profile/agent/minecraft/name/$Account).id
        if (-Not($UUID)){
            "Error: $Account not found in the Mojang API"
            continue
        }

        Write-Color "'Results for' @White ':' @DarkGray ' $Account' @Cyan"
        Write-Host "Checking Hypixel.." -NoNewline
        CheckPlancke $Account
        Write-Host "Checking Lunar.." -NoNewline
        CheckLunar $Account
        Write-Host "Checking MMC.." -NoNewline
        CheckMMC $Account
        Write-Host "Checking Manacube.." -NoNewline
        CheckManaCube $UUID
    
    }
@'

Press any key to exit ^_^
'@
    $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown') | Out-Null
} # hello github?
