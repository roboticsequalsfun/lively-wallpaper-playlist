# Lively Wallpaper Playlist

A lightweight utility that automatically cycles through your saved Lively wallpapers and assigns random wallpapers to each monitor at a configurable interval.

## 📥 Download
Download the latest installer from the **[Releases page](https://github.com/followedmefully/Lively-Wallpaper-Playlist/releases)**.

Then download the `.exe` installer and run it.

## ⚙ Requirements
- Lively Wallpaper installed
- Windows 10 or newer

## 🚀 Installation
1. Download installer
2. Run installer, amd follow the instructions to install
3. After installation, you can launch the program from the Start Menu or Desktop shortcut (if selected).

## 🧠 Configuration

After installation, open the install folder and edit `config.json`.

Settings:

- **wallpaper_folder**  
  Folder containing your Lively wallpapers.  
  This must point to Lively’s saved wallpaper folder.

  In Lively:
  Settings → General → click **Wallpaper Directory**

  Copy that path.

  Important:
  
  The folder shown by Lively is NOT the final folder.
  
  After copying it, you must add:
  
  \SaveData\wptmp

- **delay_seconds**  
  How often wallpapers change (in seconds)

- **monitors**  
  Monitor numbers matching Lively monitor numbering

- **lively_path**  
  Path to `Lively.exe`. Usually does not need changing.

## Features

- Automatically cycles through saved Lively wallpapers  
- Supports multiple monitors  
- Configurable change interval  
- Lightweight background utility

## 🧩 Planned Features

- Fix the launcher to support more devices
- A custom settings window instead of editing the config file manualy
- Automatic Lively detection
- Startup launch option
- System tray control
