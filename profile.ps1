$NConf = "C:\Users\$env:USERNAME\AppData\Local\nvim\"
$Notes = "C:\Code\Notes\"
$Code = "C:\Code\"

function Nvim-Location {
    Param([string]$Location)
    nvim $Location
}

function Goto-Code {
	Set-Location C:\Code\
	ls
}

function Goto-PersonalMyCode {
	Set-Location C:\CodeJames\
	ls
}

Function nvimInit {nvim C:/Users/$env:USERNAME/AppData/Local/nvim/init.lua}

Function nconf{
    Nvim-Location $NConf
}

Function notes{
    Nvim-Location $Notes
}

Function code{
    Nvim-Location $Code
}


Set-Alias -Name touch New-Object
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
Set-Alias -Name c -Value Goto-Code
Set-Alias -Name p2 -Value Goto-Project2
Set-Alias -Name p3 -Value Goto-Project3
Set-Alias -Name :q -Value exit


oh-my-posh init pwsh --config https://github.com/JanDeDobbeleer/oh-my-posh/themes/cobalt2.omp.json | Invoke-Expression




