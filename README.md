# Lively Wallpaper Playlist

A lightweight utility that automatically cycles through your saved Lively wallpapers and assigns random wallpapers to each monitor at a configurable interval. It is currently in alpha release.

## 📥 Download

Download the latest installer from the **[Releases page](https://github.com/followedmefully/Lively-Wallpaper-Playlist/releases/latest)** and run the `.exe` installer.

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

- **port**
  The port the instances communicate on. You do not need to change it unless another program is using it. Which is almost never.

## 📃 Logging

Lively Playlist now includes a built-in logging system to help track activity, diagnose issues, and understand how the application is behaving behind the scenes.
The log files are automatically generated and stored in the same directory as your configuration file, inside a dedicated logs subfolder.

To Open the log, right click on the system tray icon and press Open Log. It will now open the current instances log in the default text editor. **NOTE:** Currently there is only one Mega Log, but in the future it is planned for each instance to have a seperate log.

If anything goes wrong or behaves unexpectedly, checking the logs is the first step for debugging or reporting issues.

### 📝 Logging Explanation

To understand what each part of a log means, let’s look at this example:

`[HASH] YYYY-MM-DD HH:MM:SS [LEVEL] Message`

Now let’s break down each section:

- `[HASH]`   
   This is the instance hash. It acts as a unique identifier for each running instance of the program, allowing you to tell which instance generated a specific log message.

- `YYYY-MM-DD HH:MM:SS`   
   This is the timestamp showing the exact date and time the log message was created.
  
- `[LEVEL]`   
   This is the log level identifier. It indicates the type or severity of the message. There are three levels:
   - INFO — Normal messages that describe what the application is currently doing.
   - WARNING — Something is not quite right, but the application can still continue running normally.
   - ERROR — A failure or serious issue occurred that may affect functionality.

- `Message`   
  This is the actual log message describing what happened.

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
- **Improved logging system** – Separate logs per instance and a global main log for system events, with log rotation to prevent files from growing too large.
- **Automatic update checking** – Automatically check for new versions and alert user if there is.

### ⚡ Functionality

- **Shuffle modes** – Random, sequential, or weighted random playlists.
- **Per-monitor wallpaper control** – Assign specific wallpapers to certain monitors.
- **Scheduled changes** – Change wallpapers based on time of day or custom schedule.
- **Backup & restore settings** – Save user configurations for easy updating.

### 🧩 Advanced Features

- **Wallpaper tagging** – Let users tag wallpapers by category and filter which ones appear.
- **Multi-folder support** – Pull wallpapers from multiple directories.
- **Weather based wallpaper mode** - Wallpaper set by catergory based on weather and time. (User defines wallpapers for each catergory)
- **Automatic updating** – Automatically update the system and alert user that the program was update

### 💬 Feedback & Contributions

If you try this project, I’d love to hear what you think.

- 🐛 Found a bug? Open an issue
- 💡 Have an idea? Suggest a feature
- ⭐ Like the project? Consider starring it
