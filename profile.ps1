
Set-Alias -Name ll "Get-ChildItem -Force"
Set-Alias -Name reboot "Restart-Computer -f"
Set-Alias -Name ub3 -Value "C:\PersonalMyCode\UpdateBudget3\main.ps1"
Set-Alias -Name touch -Value New-Item

oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/cobalt2.omp.json' | Invoke-Expression

#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58
