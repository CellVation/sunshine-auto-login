# Sunshine Auto-Login Installer

Write-Host "==============================================" -ForegroundColor Cyan
Write-Host "   Sunshine Silent Auto-Login Installer" -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "This script will:"
Write-Host "1. Configure Sunshine Service to run automatically in the background."
Write-Host "2. Install a silent login script to your Startup folder."
Write-Host "3. Remove the default browser-opening shortcut if present."
Write-Host ""

# Check for Administrator privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "This script requires Administrator privileges to configure the Sunshine Service."
    Write-Warning "Please run this script as Administrator."
    Pause
    Exit
}

# 1. Get Credentials
Write-Host "Please enter your Sunshine Web UI credentials:" -ForegroundColor Yellow
$username = Read-Host "Username"
$password = Read-Host "Password"

if ([string]::IsNullOrWhiteSpace($username) -or [string]::IsNullOrWhiteSpace($password)) {
    Write-Error "Username and Password cannot be empty."
    Pause
    Exit
}

# 2. Configure Service
Write-Host ""
Write-Host "Configuring Sunshine Service..." -ForegroundColor Yellow
try {
    $service = Get-Service -Name "SunshineService" -ErrorAction Stop
    Set-Service -Name "SunshineService" -StartupType Automatic
    if ($service.Status -ne 'Running') {
        Start-Service -Name "SunshineService"
    }
    Write-Host "OK: Sunshine Service set to Automatic and Running." -ForegroundColor Green
}
catch {
    Write-Error "Failed to configure SunshineService. Is Sunshine installed?"
    Write-Error $_.Exception.Message
}

# 3. Create Login Script
Write-Host ""
Write-Host "Installing Silent Login Script..." -ForegroundColor Yellow
$templatePath = Join-Path $PSScriptRoot "login_template.vbs"
$startupPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\sunshine_auto_login.vbs"

if (Test-Path $templatePath) {
    try {
        $content = Get-Content -Path $templatePath -Raw
        $content = $content -replace "{{USERNAME}}", $username
        $content = $content -replace "{{PASSWORD}}", $password
        
        Set-Content -Path $startupPath -Value $content -Force
        Write-Host "OK: Login script created at: $startupPath" -ForegroundColor Green
    }
    catch {
        Write-Error "Failed to create login script."
        Write-Error $_.Exception.Message
    }
}
else {
    Write-Error "Template file 'login_template.vbs' not found in script directory!"
}

# 4. Cleanup old shortcuts
Write-Host ""
Write-Host "Cleaning up old shortcuts..." -ForegroundColor Yellow
$oldShortcut = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\Sunshine.lnk"
if (Test-Path $oldShortcut) {
    Remove-Item -Path $oldShortcut -Force
    Write-Host "OK: Removed old Sunshine startup shortcut (prevents browser popup)." -ForegroundColor Green
} else {
    Write-Host "OK: No old shortcut found." -ForegroundColor Gray
}

Write-Host ""
Write-Host "Installation Complete!" -ForegroundColor Cyan
Write-Host "Sunshine will now run silently on startup and automatically log in."
Pause
