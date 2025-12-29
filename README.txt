Sunshine Silent Auto-Login Installer
====================================

This tool configures Sunshine Game Stream to run silently in the background on startup and automatically "logs in" to the web interface without opening a visible browser window.

How It Works
------------
1. Service Configuration: It changes the "SunshineService" startup type to Automatic. This ensures the core server runs immediately when Windows starts, without waiting for a user to log in or launching the visible tray application/browser.

2. Silent Login Script: It generates a custom VBScript (sunshine_auto_login.vbs) using the credentials you provide. This script is placed in your Windows Startup folder.

3. Authentication: When you log in to Windows, the VBScript runs silently (no pop-up window) and sends an HTTP request to https://localhost:47990/. It uses your credentials to authenticate with the Sunshine Web UI, satisfying the "login" requirement so streaming can work.

4. Cleanup: It searches for and removes the default "Sunshine" shortcut from the Startup folder to prevent the browser popping up.

Directions for Use
------------------
1. Double-click "Setup.bat".

2. If prompted by User Account Control (UAC), click "Yes" to grant Administrator privileges. (This is required to change Service settings).

3. When prompted, enter your Sunshine Username and Password.

4. Press Enter.

5. Wait for the "Installation Complete" message.

That's it! You can now restart your computer. Sunshine will run in the background, and you will be automatically logged in ensuring your game stream is ready to go.
