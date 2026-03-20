Set-Alias -Name reboot "Restart-Computer -f"
Set-Alias -Name ub3 -Value "C:\PersonalMyCode\UpdateBudget3\main.ps1"
Set-Alias -Name touch -Value New-Item

function ll {
    Get-ChildItem -Force | Where-Object { $_.Attributes -notlike "*System*" }
}

oh-my-posh init pwsh --config "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/thecyberden.omp.json" | Invoke-Expression
