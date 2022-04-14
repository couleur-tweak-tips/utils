function rankchecker {
[CmdletBinding()]param(
    [Parameter(ValueFromRemainingArguments = $true)][String]$sexyargs
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
    
    if ($sexyargs -eq '-'){
        $Arguments = (Get-Clipboard) -Split '\r?\n'
    }else{
        $Arguments = $sexyargs
    }
    ForEach($Account in $Arguments){
        if ($All){
            start https://manacube.com/stats/player/$Account
            start https://minemen.club/player/$Account
        }
        Write-Color "'Results for' @White ':' @DarkGray ' $Account' @Cyan"
        Write-Host "Checking Hypixel.." -NoNewline
        CheckPlancke $Account
        Write-Host "Checking Lunar.." -NoNewline
        CheckLunar $Account
        Write-Host https://minemen.club/player/$Account -ForegroundColor DarkGray
        Write-Host https://manacube.com/stats/player/$Account -ForegroundColor DarkGray
    
    }
}
