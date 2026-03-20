Write-Host "`n`nWelcome to OneShot!"
# Check for Administrative privileges
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as an Administrator. Exiting..."
    exit
}

Write-Host "`n`nAdmin check passed. Proceeding with execution..." -ForegroundColor Green

Write-Host "Starting Ninite" -ForegroundColor Cyan
$apps = "chrome-firefox-windirstat-zoom-audacity-vlc-googledrive-notepadplusplus-vscode-gimp-googleearth-steam"
$url = "https://ninite.com/$apps/ninite.exe"
$tempPath = "$env:TEMP\NiniteInstaller.exe"

#Download the stub
Write-Host "Downloading Ninite for: $apps" -ForegroundColor Cyan
Invoke-WebRequest -Uri $url -OutFile $tempPath

#Execute and Wait
Write-Host "Installing..." -ForegroundColor Yellow
Start-Process -FilePath $tempPath -Wait

#Clean up
Remove-Item $tempPath
Write-Host "Clean up complete. Ninite apps installed!" -ForegroundColor Green


Write-Host "`n`nInstalling Chocolately" -ForegroundColor Cyan
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Refresh environment variables
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")



Write-Host "`n`nInstalling choco apps" -ForegroundColor Cyan

$chocoApps = @("git.install", "pwsh", "powertoys", "neovim", "autohotkey.install", "grep")

foreach ($app in $chocoApps) {
    Write-Host "--- Installing $app ---"
    choco install $app -y --no-progress
}

# Refresh environment variables
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")



Write-Host "`n`nSetting Git Globals" -ForegroundColor Cyan
git config --global user.name "James Fluckiger"
git config --global user.email "jamesafluke@gmail.com"



Write-Host "`n`nAdding nvim config" -ForegroundColor Cyan
$nvimConfigPath = Join-Path $env:LOCALAPPDATA "nvim"

if (!(Test-Path $nvimConfigPath)) {
    New-Item -ItemType Directory -Force -Path $nvimConfigPath
}

$nvimConfigDir = "$env:LOCALAPPDATA\nvim"
$initLuaPath = "$nvimConfigDir\init.lua"
New-Item -ItemType Directory -Force -Path $nvimConfigDir
$rawUrl = "https://raw.githubusercontent.com/Jamesafluke/Config/main/nvim/init.lua"
Invoke-WebRequest -Uri $rawUrl -OutFile $initLuaPath

Write-Host "Neovim init.lua added." -ForegroundColor Green




Write-Host "`n`nDownloading JetBrains Mono Zip..." -ForegroundColor Cyan

$fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
$tempZip = "$env:TEMP\JetBrainsMono.zip"
$tempFontFolder = "$env:TEMP\JetBrainsMonoFont"
Invoke-WebRequest -Uri $fontUrl -OutFile $tempZip

# 2. Extract the zip
if (Test-Path $tempFontFolder) { Remove-Item $tempFontFolder -Recurse -Force }
Expand-Archive -Path $tempZip -DestinationPath $tempFontFolder

# 3. Move and Register Fonts
Write-Host "Registering Fonts in Windows..." -ForegroundColor Yellow
$shellApp = New-Object -ComObject Shell.Application
$fontFolder = $shellApp.Namespace(0x14) # 0x14 is the 'Fonts' special folder

Get-ChildItem -Path $tempFontFolder -Filter "*Windows Compatible.ttf" | ForEach-Object {
    if (!(Test-Path "C:\Windows\Fonts\$($_.Name)")) {
        $fontFolder.CopyHere($_.FullName, 0x10) # 0x10 avoids showing progress dialogs
    }
}

# 4. Clean up
Remove-Item $tempZip
Remove-Item $tempFontFolder -Recurse
Write-Host "JetBrains Mono Nerd Font Installed!" -ForegroundColor Green


Write-Host "`n`nApplying Windows Personalization"
# --- Taskbar & Start Menu ---
$adv = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$search = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
$taskbar = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

# Align Left (0=Left, 1=Center), Hide Task View (0), Hide Widgets (0)
Set-ItemProperty -Path $adv -Name "TaskbarAl" -Value 0
Set-ItemProperty -Path $adv -Name "ShowTaskViewButton" -Value 0

# Hide Search (0 = Hidden)
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0

# Don't show badges (0) / Don't show flashing (0)
Set-ItemProperty -Path $adv -Name "TaskbarMn" -Value 0
Set-ItemProperty -Path $adv -Name "TaskbarFlashing" -Value 0

# Remove Desktop Button from corner (Disable "Peek")
Set-ItemProperty -Path $adv -Name "DisablePreviewDesktop" -Value 1

# Combine buttons when taskbar is full (2 = When full, 0 = Always, 1 = Never)
Set-ItemProperty -Path $adv -Name "TaskbarGlomLevel" -Value 2
Set-ItemProperty -Path $adv -Name "MMTaskbarGlomLevel" -Value 2

# Hide Recommended section in Start (This clears the content, doesn't hide the empty space)
Set-ItemProperty -Path $adv -Name "Start_TrackDocs" -Value 0

# --- Snap Windows & Alt+Tab ---
$windowUI = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

# Turn off Snap suggestions & Layouts
Set-ItemProperty -Path $windowUI -Name "SnapAssist" -Value 0
Set-ItemProperty -Path $windowUI -Name "EnableSnapLayouts" -Value 0
Set-ItemProperty -Path $windowUI -Name "DndMaximizedDrag" -Value 0 
Set-ItemProperty -Path $windowUI -Name "TaskbarAnimations" -Value 0

# Alt+Tab: Open windows only (No browser tabs)
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MultiTaskingALTTabFilter" -Value 3

# --- System & Accessibility ---
# Set Timezone to Mountain Time
tzutil /s "Mountain Standard Time"

# Turn off Sticky Keys shortcut
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Value "506"

# Turn off Web Search in Start Menu
if (!(Test-Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer")) { New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Force }
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1

# --- Power Settings (25m Screen, 30m Sleep) ---
powercfg /change monitor-timeout-ac 25
powercfg /change monitor-timeout-dc 25
powercfg /change standby-timeout-ac 30
powercfg /change standby-timeout-dc 30

# --- File Explorer ---
$explorer = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $explorer -Name "HideFileExt" -Value 0
Set-ItemProperty -Path $explorer -Name "Hidden" -Value 1

# --- Disable Copilot & Tips ---
$policyPath = "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot"
if (!(Test-Path $policyPath)) { New-Item -Path $policyPath -Force }
Set-ItemProperty -Path $policyPath -Name "TurnOffWindowsCopilot" -Value 1

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Value 0 # Tips/Tricks
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenEnabled" -Value 0 # Lockscreen Tips

Write-Host "Settings applied. Note: Some UI changes require an Explorer restart." -ForegroundColor Yellow
# --- Start Menu: Hide Recommended Content ---
# This stops Windows from populating the bottom half of the Start Menu. 
# The "section" remains, but it will be empty.
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Value 0

# --- Taskbar: Disable News, Interests, and Widgets ---
# This removes the Widgets icon (the weather/news feed) from the taskbar.
$policiesExplorer = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
if (!(Test-Path $policiesExplorer)) { New-Item -Path $policiesExplorer -Force }
Set-ItemProperty -Path $policiesExplorer -Name "DisableSearchBoxSuggestions" -Value 1 # Web Search

Write-Host "Restarting Explorer to apply UI changes..." -ForegroundColor Yellow
Stop-Process -Name explorer -Force
Start-Process explorer.exe

Write-Host "`n`nOneshot is done!" -ForegroundColor Cyan

