# Ensure running as administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Please run this script as Administrator!"
    exit 1
}

# Enable required features for WSL2
Write-Host "Installing WSL2 and required features..." -ForegroundColor Cyan
wsl --install -d Ubuntu

# Install Docker Desktop (WSL2 backend is default now)
Write-Host "Installing Docker Desktop..." -ForegroundColor Cyan
winget install -e --id Docker.DockerDesktop --source winget

# Install JetBrains IntelliJ IDEA Ultimate
Write-Host "Installing IntelliJ IDEA Ultimate..." -ForegroundColor Cyan
winget install -e --id JetBrains.IntelliJIDEA.Ultimate --source winget

# Install Tabnine Code Completion
Write-Host "Installing Tabnine..." -ForegroundColor Cyan
winget install -e --id Tabnine.Tabnine --source winget

# Placeholder: Claude Code, Windsurf Code, Meetily Front End
Write-Host "Please manually install Claude Code, Windsurf Code, and Meetily Front End." -ForegroundColor Yellow

# Install Python 3.11
Write-Host "Installing Python 3.11..." -ForegroundColor Cyan
winget install -e --id Python.Python.3.11 --source winget

# Install Rufus
Write-Host "Installing Rufus..." -ForegroundColor Cyan
winget install -e --id Rufus.Rufus --source winget

# Confirm installed packages
Write-Host "`nInstallation script complete!" -ForegroundColor Green
winget list | Where-Object { $_.Id -match "Docker|IntelliJ|Tabnine|Python|Rufus" }
