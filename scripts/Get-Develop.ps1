[CmdletBinding()]
param(

)

# ----------------------------------
# Game Variables
# ----------------------------------
$gameName = "CoffeeCompany"
$workDir = "C:\Users\$($env:USERNAME)\Documents\1_MainDrive\4_GitHub"
$downloadDir = "C:\Users\$($env:USERNAME)\Downloads"

# Local Variables
$gameDir = Join-Path -Path $workDir -ChildPath $gameName
$scriptDir = Split-Path -Parent $PSScriptRoot
$downloadFile = Join-Path -Path $downloadPath -ChildPath "template"

while ($true) {
    Clear-Host
    Write-Host "==== Get-Develop ====" -ForegroundColor Cyan
    Write-Host "1. Install Developer Tools" -ForegroundColor Cyan
    Write-Host "2. Download 'The agb book' Developer Template" -ForegroundColor Cyan
    Write-Host "3. Run your game in Debug Mode (if available)" -ForegroundColor Yellow
    Write-Host "4. Run your game in Cheat Mode (if available)" -ForegroundColor Red
    Write-Host "5. Run your game in Release Mode" -ForegroundColor Green
    Write-Host "6. Compile your game for GBA Hardware" -ForegroundColor Magenta
    Write-Host "7. Clean Cargo" -ForegroundColor Cyan
    Write-Host "Q. Quit" -ForegroundColor Cyan

    $decision = Read-Host -Prompt "(Default - 5)"
    switch ($decision) {
        "1" {
            Write-Host "Checking for Developer Tools..." -ForegroundColor Cyan
            # ----------------------------------
            # Try to Find Git
            # ----------------------------------
            try { 
                if (Get-Command -Name "git" -ErrorAction SilentlyContinue) {
                    $gitVersion = (git --version).Trim()
                    Write-Host "$gitVersion" -ForegroundColor Green
                } else {
                    Write-Host "Git is not installed." -ForegroundColor Yellow
                    Write-Host "Would you like to install Git? (This will open a browser to download the GUI installer)" -ForegroundColor Cyan
                    $cmd = Read-Host -Prompt "(Y/n)"
                    if ($cmd -eq "Y") {
                        Start-Process "https://github.com/git-guides/install-git"
                    } else {
                        Write-Host "Git installation canceled." -ForegroundColor Yellow
                    }
                }
            } catch {
                Write-Host "An error occurred while checking for Git." -ForegroundColor Red
                Write-Debug $_.Exception.Message
            }
            # ----------------------------------
            # Try to Find Rust
            # ----------------------------------
            try {
                if (Get-Command -Name "rustc" -ErrorAction SilentlyContinue) {
                    $rustVersion = (rustc --version).Trim()
                    Write-Host "$rustVersion" -ForegroundColor Green
                } else {
                    Write-Host "Rust is not installed." -ForegroundColor Yellow
                    Write-Host "Would you like to install Rust? (This will open a browser to download the installer)" -ForegroundColor Cyan
                    $cmd = Read-Host -Prompt "(Y/n)"
                    if ($cmd -eq "Y") {
                        Start-Process "https://www.rust-lang.org/tools/install"
                    } else {
                        Write-Host "Rust installation canceled." -ForegroundColor Yellow
                    }
                }
            } catch {
                Write-Host "An error occurred while checking for Rust." -ForegroundColor Red
                Write-Debug $_.Exception.Message
            }
            # ----------------------------------
            # Try to Find Rustup
            # ----------------------------------
            try {
                if (Get-Command -Name "rustup" -ErrorAction SilentlyContinue) {
                    $rustupVersion = (rustup --version).Trim()
                    Write-Host "$rustupVersion" -ForegroundColor Green
                } else {
                    Write-Host "Rustup is not installed." -ForegroundColor Yellow
                    Write-Host "Would you like to install Rustup? (This will open a browser to download the installer)" -ForegroundColor Cyan
                    $cmd = Read-Host -Prompt "(Y/n)"
                    if ($cmd -eq "Y") {
                        Start-Process "https://rustup.rs/"
                    } else {
                        Write-Host "Rustup installation canceled." -ForegroundColor Yellow
                    }
                }
            } catch {
                Write-Host "An error occurred while checking for Rustup." -ForegroundColor Red
                Write-Debug $_.Exception.Message
            }
            # ----------------------------------
            # Try to Find agb-gbafix
            # ----------------------------------
            try {
                if (Get-Command -Name "agb-gbafix" -ErrorAction SilentlyContinue) {
                    $agbGbafixVersion = (agb-gbafix --version).Trim()
                    Write-Host "$agbGbafixVersion" -ForegroundColor Green
                } else {
                    Write-Host "agb-gbafix is not installed." -ForegroundColor Yellow
                    Write-Host "Would you like to install agb-gbafix? (This will use a cargo command to install)" -ForegroundColor Cyan
                    $cmd = Read-Host -Prompt "(Y/n)"
                    if ($cmd -eq "Y") {
                        cargo install agb-gbafix
                    } else {
                        Write-Host "agb-gbafix installation canceled." -ForegroundColor Yellow
                    }
                }
            } catch {
                Write-Host "An error occurred while checking for agb-gbafix." -ForegroundColor Red
                Write-Debug $_.Exception.Message
            }
            # ----------------------------------
            # Create Link for agb-gbafix
            # ----------------------------------
            try {
                Write-Host "Creating Link for agb-gbafix..." -ForegroundColor Cyan
                New-Item -itemtype hardlink -path "C:\Program Files\mGBA\mgba-qt.exe" -value "C:\Program Files\mGBA\mGBA.exe"
                Write-Host "Link created successfully." -ForegroundColor Green
            } catch {
                Write-Host "An error occurred while creating the link for agb-gbafix." -ForegroundColor Red
                Write-Debug $_.Exception.Message
            }
            Write-Host "All Developer Tools Checked and/or Installed." -ForegroundColor Green
            Read-Host -Prompt ": Press Enter to continue"
        }
        "2" {
            Write-Host "Getting Developer Template from 'The agb book'..." -ForegroundColor Cyan
            # ----------------------------------
            # Set Download Path
            # ----------------------------------
            try {
                $downloadPath = Read-Host -Prompt "Enter the download path (Default: $downloadDir)"
                if ([string]::IsNullOrWhiteSpace($downloadPath)) {
                    $downloadPath = $downloadDir
                }
            } catch {
                Write-Host "An error occurred while setting the download path." -ForegroundColor Red
                Write-Debug $_.Exception.Message
            }
            # ----------------------------------
            # Download Developer Template
            # ----------------------------------
            try {
                Write-Host "Downloading Developer Template to $downloadPath..." -ForegroundColor Cyan
                git clone https://github.com/agbrs/template.git $downloadPath
                Write-Host "Developer Template downloaded successfully." -ForegroundColor Green
            } catch {
                Write-Host "An error occurred while downloading the Developer Template." -ForegroundColor Red
                Write-Debug $_.Exception.Message
            }
            # ----------------------------------
            # Rename Downloaded Template Folder
            # ----------------------------------
            try {
                $newFolderName = Read-Host -Prompt "Enter the new folder name for the Developer Template (Default: $gameName)"
                if ([string]::IsNullOrWhiteSpace($newFolderName)) {
                    $newFolderName = $gameName
                }
                $newFolderPath = Join-Path -Path $downloadPath -ChildPath $newFolderName
                if (Test-Path $newFolderPath) {
                    Write-Host "Folder with the name $newFolderName already exists." -ForegroundColor Red
                } else {
                    Rename-Item -Path $downloadFile -NewName $newFolderName
                    Write-Host "Folder renamed successfully to $newFolderName." -ForegroundColor Green
                }
            } catch {
                Write-Host "An error occurred while renaming the Developer Template folder." -ForegroundColor Red
                Write-Debug $_.Exception.Message
            }
        }
        "3" {

        }
        "4" {

        }
        "5" {

        }
        "6" {

        }
        "7" {

        }
        "Q" { 
            exit 0
        }
        default {
            Write-Host "Invalid selection." -ForegroundColor Red
            Read-Host -Prompt ": Press Enter to continue"
        }
    }
}
    