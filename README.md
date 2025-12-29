# Sunshine Silent Auto-Login

[![GitHub release (latest by date)](https://img.shields.io/github/v/release/CellVation/sunshine-auto-login)](https://github.com/CellVation/sunshine-auto-login/releases/latest)
[![GitHub last commit](https://img.shields.io/github/last-commit/CellVation/sunshine-auto-login)](https://github.com/CellVation/sunshine-auto-login/commits/main)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A lightweight installer for Windows that configures **Sunshine Game Stream** (by LizardByte) to run silently in the background on system startup and automatically handles the web browser login requirement.

## 🚀 Features

- **No Browser Popups**: Prevents the default Sunshine launcher from opening your web browser on every startup.
- **Silent Authentication**: Automatically performs the login (Basic Auth) in the background.
- **Background Service**: Configures Sunshine to run as a native Windows service.
- **Zero Configuration (Post-Install)**: Set your credentials once during installation and never think about it again.

## 🛠️ How It Works

1. **Service Mode**: The installer sets the `SunshineService` to "Automatic" startup.
2. **Scheduled Login**: Installs a specialized VBScript in the Windows Startup folder that waits for the service to be ready and then authenticates silently.
3. **Ghost Mode**: Removes original startup shortcuts to ensure a clean, silent boot experience.

## 📦 Installation

1. **[Download the Latest Package (.zip)](https://github.com/CellVation/sunshine-auto-login/releases/latest/download/SunshineAutoLogin.zip)**
2. Extract the folder.
3. Double-click **`Setup.bat`**.
4. Grant Administrative privileges when prompted.
5. Enter your Sunshine Web UI credentials.

## 🔍 Why is this needed?

By default, Sunshine is designed to open its Web UI in a browser on startup to ensure the user is logged in. This can be annoying for HTPCs or headless servers. This tool bridges that gap by automating the login handshake silently.

---
*Disclaimer: This is a community-made tool and is not officially affiliated with LizardByte or the Sunshine project.*
