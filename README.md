# Lively Wallpaper Playlist

A lightweight utility that automatically cycles through your saved Lively wallpapers and assigns random wallpapers to each monitor at a configurable interval.

## 📥 Download

Download the latest installer from the **[Releases page](https://github.com/followedmefully/Lively-Wallpaper-Playlist/releases)** and run the `.exe` installer.

## ⚙ Requirements

- Lively Wallpaper installed
- Windows 10 or newer

## 🚀 Installation

1. Download the installer.
2. Run the installer and follow the instructions. (Note: windows will try blocking the program since it uses a python executable. Just lick more info, annd then press run anyway.)
3. When it asks for the monitor numbers just look at your lively wallpaper monitors and copy that. (Note: It is currently broken and will not actually do anything)
4. When it asks for the the path that contains your Lively wallpapers go to lively and go to Settings → General → click **Wallpaper Directory** and copy that path.   
**Important:** The folder shown by Lively is **not** the final folder. After copying it, you must add `\SaveData\wptmp`.
5. Then choose how you intalled lively (Note: This feature is kind of broken and will be fixed shortly)
6. Find the config file (located in the same folder that the program was downloaded to) and edit to monitors to match lively. Also under the lively_path variable get rid of the \\\Roaming part (THIS WILL BE FIXED IN A COUPLE OF DAYS!)
7. After installation, launch the program from the Start Menu or Desktop shortcut (if selected).

## 🧠 Configuration

After installation, open the install folder and edit `config.json`.  

Settings:

- **wallpaper_folder**  
  The folder containing your Lively wallpapers.  
  This must point to Lively’s saved wallpaper folder.

  In Lively:  
  Settings → General → click **Wallpaper Directory** and copy that path.  
  **Important:** The folder shown by Lively is **not** the final folder. After copying it, you must add `\SaveData\wptmp`.

- **delay_seconds**  
  How often wallpapers change (in seconds).

- **monitors**  
  Monitor numbers matching Lively monitor numbering (e.g., `1,2`).

- **lively_path**  
  Path to `Lively.exe`. Usually does not need changing.

## Features

- Automatically cycles through saved Lively wallpapers  
- Supports multiple monitors  
- Configurable change interval  
- Lightweight background utility

## 🧩 Planned Features

- Make the launcher support more devices and be more intuitive
- Add a custom settings window instead of manually editing the config file
- Automatic detection of Lively Wallpaper’s install location
- Optionally allow selecting which wallpapers are included
