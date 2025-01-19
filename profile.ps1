$user = "v-jfluckiger"
$user = "jfluckiger"
$user = "james"

Set-Alias touch New-Object
Set-Alias n nvim
Set-Alias nconfig Goto-NeovimConfig
Set-Alias -Name nethackconfig -Value Goto-NetHackConfig
Set-Alias -Name p1 Goto-Project1
Set-Alias -Name pmc Goto-PersonalMyCode
Set-Alias -Name ll "Get-ChildItem -Force"
Set-Alias -Name t -Value terraform
Set-Alias -Name k -Value kubectl
Set-Alias -Name g -Value git
Set-Alias -Name ub3 -Value "C:\PersonalMyCode\UpdateBudget3\main.ps1"
Set-Alias -Name vi -Value nvim
Set-Alias -Name v -Value nvim
Set-Alias -Name vim -Value nvim
Set-Alias -Name touch -Value New-Item
Set-Alias -Name p2 -Value Goto-Project2
Set-Alias -Name p3 -Value Goto-Project3

function Goto-NeovimConfig {
	Set-Location C:\Users\$user\AppData\Local\nvim\
}

function Goto-NetHackConfig {
	vim C:\users\$user\NetHack\.nethackrc
}

function Goto-Project2 {
	Set-Location C:\PersonalMyCode\BudgetUpdator\
	ls
}

function Goto-PersonalMyCode {
	Set-Location C:\PersonalMyCode\
	pwd
}

Function nvimInit {nvim C:/Users/$user/AppData/Local/nvim/init.lua}
