# Lively Wallpaper Playlist

A lightweight utility that automatically cycles through your saved Lively wallpapers and assigns random wallpapers to each monitor at a configurable interval. It is currently in alpha release.

## 📥 Download

Download the latest installer from the **[Releases page](https://github.com/followedmefully/Lively-Wallpaper-Playlist/releases/tag/v0.4)** and run the `.exe` installer.

## ⚙ Requirements

- Lively Wallpaper installed
- Windows 10 or newer

## 🚀 Installation

1. Download the installer.
2. Run the installer and follow the instructions. (Note: Windows SmartScreen may warn that the app is from an unknown publisher. Click **More info → Run anyway** to continue.)
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

## Features

- Automatically cycles through saved Lively wallpapers
- Supports multiple monitors
- Configurable settigns
- Lightweight background utility
- Easy to use
- System tray icon
- Single-instance enforcement

## 🧩 Planned Features

### 🎯 Usability & Interface

- **Graphical settings window** – A more intuitive way to change the programs settings.
- **Drag-and-drop wallpaper selection** – Let users select which wallpapers are included/excluded.
- **Built-in path detection** – Auto-detect Lively install folder, wallpaper folder, and monitors, even for Microsoft Store installs.

### ⚡ Functionality

- **Shuffle modes** – Random, sequential, or weighted random playlists.
- **Per-monitor wallpaper control** – Assign specific wallpapers to certain monitors.
- **Scheduled changes** – Change wallpapers based on time of day or custom schedule.
- **Backup & restore settings** – Save user configurations for easy recovery.

### 🧩 Advanced Features

- **Wallpaper tagging** – Let users tag wallpapers by category and filter which ones appear.
- **Multi-folder support** – Pull wallpapers from multiple directories.
- **Integration with Lively playlists** – Detect Lively’s internal playlists and work with them.
- **Logging & error reporting** – Log failed wallpaper changes or invalid monitor numbers.
