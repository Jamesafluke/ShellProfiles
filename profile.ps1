

$code = "C:\Code\"
$notes = "C:\Users\v-fluckigerj\OneDrive\Notes\"
$xboxDaily = "C:\Users\v-fluckigerj\OneDrive\Notes\Xbox.txt"
$cSharp = "C:\Users\v-fluckigerj\OneDrive\Notes\C#"
$generalXbox = "C:\Users\v-fluckigerj\OneDrive\Notes\XboxGeneral"

function notes{
	Set-Location $notes
	ls
}

Function note{
    Nvim-Location $Notes
}

Function cnote{
    Nvim-Location $cSharp
}

Function general{
    Nvim-Location $generalXbox
}


Set-Alias -Name n nvim
Set-Alias -Name ll "Get-ChildItem -Force"
Set-Alias -Name t -Value terraform
Set-Alias -Name k -Value kubectl
Set-Alias -Name g -Value git
Set-Alias -Name ub3 -Value "C:\PersonalMyCode\UpdateBudget3\main.ps1"
Set-Alias -Name vi -Value nvim
Set-Alias -Name v -Value nvim
Set-Alias -Name vim -Value nvim
Set-Alias -Name touch -Value New-Item


oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/cobalt2.omp.json' | Invoke-Expression

#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58
