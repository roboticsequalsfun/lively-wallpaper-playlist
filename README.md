# Lively Wallpaper Playlist

A lightweight utility that automatically cycles through your saved Lively wallpapers and assigns random wallpapers to each monitor at a configurable interval. It is currently in alpha release.

## 📥 Download

Download the latest installer from the **[Releases page](https://github.com/followedmefully/Lively-Wallpaper-Playlist/releases/tag/v0.5-alpha)** and run the `.exe` installer.

## ⚙ Requirements

- Lively Wallpaper installed
- Windows 10 or newer

## 🚀 Installation

1. Download the installer.
2. Run the installer and follow the instructions. (Note: Windows SmartScreen may warn that the app is from an unknown publisher. Click **More info → Run anyway** to continue. Don't worry it's not a virus (Check the source code if your scared (I would))
3. If Lively cannot be found, manually locate `Lively.exe`
   Microsoft Store installs are usually located in:
   `%LocalAppData%\\Packages\\12030rocksdanister.LivelyWallpaper_97hta09mmv6hy\\LocalCache\\Local`
   or
   `%LocalAppData%\\Packages\\12030rocksdanister.LivelyWallpaper_97hta09mmv6hy\\Build`
4. When it asks for monitor numbers, check your Lively Wallpaper monitor settings and use that (Note: It must have comma's between monitor numbers, e.g`1,2`).
5. When it asks for the folder containing your Lively wallpapers, open Lively → Settings → General → **Wallpaper Directory** and use that path.

## 🧠 Configuration

To configure settings, right click on the system tray icon and press Edit Config. `config.json` Will now open up.

Settings:

- **wallpaper_folder**  
  The folder containing your Lively wallpapers.  
  This must point to Lively’s saved wallpaper folder.

  In Lively:  
  Settings → General → click **Wallpaper Directory** and copy that path.  
  #### ⚠**IMPORTANT:** The folder shown by Lively is **not** the final folder. After copying it, **append** `\SaveData\wptmp`.

- **delay_seconds**  
  How often wallpapers change (in seconds).

- **monitors**  
  Monitor numbers matching Lively monitor numbering with comma's between monitor numbers (e.g., `1,2`).

- **lively_path**  
  Path to `Lively.exe`. Usually does not need changing, unless lively has been reinstalled

## 📃 Logging

Lively Playlist now includes a built-in logging system to help track activity, diagnose issues, and understand how the application is behaving behind the scenes.

The log files are automatically generated and stored in the same directory as your configuration file, inside a dedicated logs subfolder.

### 📍 How to find your log files:
   1. **Start Lively Playlist**
      Launch the application normally so it initializes its configuration and logging system.
   2. **Open the system tray menu**
      Locate the Lively Playlist icon in your system tray (bottom-right corner of your screen).
   3. **Access the config location**
      Right-click the tray icon and select “Open Config”.
   4. **Open folder automatically**
      This will open your default file editor or file explorer directly at the configuration file location.
   
   5. **Locate the logs folder**
      In the same directory where the config file is stored, you will find a folder named:
   
   `logs/`
   
   This folder contains all generated log files.

If anything goes wrong or behaves unexpectedly, checking the logs is the first step for debugging or reporting issues.

## ⚙️ Features

- Runs in the system tray
- Automatically detects when config changes and applies new settings without needing to restart
- Uses the Lively Wallpaper command-line tool to set wallpapers, allowing it to work with both local and web wallpapers saved in Lively
- Logs all actions and errors to a log file with a unique instance ID for easier debugging when multiple instances are accidentally opened
- Enforces a single running instance
- Randomly chooses wallpapers from subfolders of the specified directory
- Easy shutdown and restart of the wallpaper shuffling thread when config changes or when the user clicks "Next Wallpaper" in the menu
- Works with multiple monitors
- Configurable via config.json

## 🧩 Planned Features

### 🎯 Usability & Interface

- **Graphical settings window** – A more intuitive way to change the programs settings.
- **Drag-and-drop wallpaper selection** – Let users select which wallpapers are included/excluded.
- **Built-in path detection** – Auto-detect Lively install folder, wallpaper folder, and monitors, even for Microsoft Store installs.
- **Open logs tray option** – A system tray option that opens the current instance’s log file.
- **Improved logging system** – Separate logs per instance and a global main log for system events, with log rotation to prevent files from growing too large.

### ⚡ Functionality

- **Shuffle modes** – Random, sequential, or weighted random playlists.
- **Per-monitor wallpaper control** – Assign specific wallpapers to certain monitors.
- **Scheduled changes** – Change wallpapers based on time of day or custom schedule.
- **Backup & restore settings** – Save user configurations for easy recovery.

### 🧩 Advanced Features

- **Wallpaper tagging** – Let users tag wallpapers by category and filter which ones appear.
- **Multi-folder support** – Pull wallpapers from multiple directories.
- **Logging & error reporting** – Log failed wallpaper changes or invalid monitor numbers.
- **Weather based wallpaper mode** - Wallpaper set by catergory based on weather and time. (User defines wallpapers for each catergory)
