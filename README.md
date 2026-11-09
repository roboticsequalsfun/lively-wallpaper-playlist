# Lively Wallpaper Playlist

A lightweight utility that automatically cycles through your saved Lively wallpapers and assigns random wallpapers to each monitor at a configurable interval.

> **Status:** Alpha Release

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Logging](#logging)
  - [Opening Logs](#opening-logs)
  - [Log Format](#log-format)
  - [Log Levels](#log-levels)
- [Roadmap](#roadmap)
  - [Usability & Interface](#usability--interface)
  - [Core Functionality](#core-functionality)
  - [Advanced Features](#advanced-features)
- [Feedback & Contributions](#feedback--contributions)

---

## Overview

Lively Wallpaper Playlist automatically shuffles wallpapers from your Lively Wallpaper library, assigning random wallpapers to your monitors at a configurable interval.

The application runs in the system tray and supports multiple monitors, automatic configuration updates, and logging.

---

## Features

- [x] Runs in the system tray.
- [x] Automatically detects when config changes and applies new settings without needing to restart.
- [x] Logs all actions and errors to a log file with a unique instance ID for easier debugging when multiple instances are accidentally opened.
- [x] Enforces a single running instance.
- [x] Randomly chooses wallpapers from subfolders of the specified directory.
- [x] Easy shutdown and restart of the wallpaper shuffling thread when config changes or when the user clicks "Next Wallpaper" in the menu.
- [x] Works with multiple monitors.
- [x] Configurable via `config.json`.

---

## Requirements

- Lively Wallpaper installed.
- Windows 10 or newer.

---

## Installation

1. Download the latest installer from the **[Releases page](https://github.com/followedmefully/Lively-Wallpaper-Playlist/releases/latest)**.
2. Run the `.exe` installer and follow the instructions.

   > **Note:** Windows SmartScreen may warn that the app is from an unknown publisher. Click **More info → Run anyway** to continue. Don't worry it's not a virus (Check the source code if your scared (I would)).

3. If Lively cannot be found, manually locate `Lively.exe`.

   Microsoft Store installs are usually located in one of the following directories:

   ```text
   %LocalAppData%\Packages\12030rocksdanister.LivelyWallpaper_97hta09mmv6hy\LocalCache\Local
   ```

   or

   ```text
   %LocalAppData%\Packages\12030rocksdanister.LivelyWallpaper_97hta09mmv6hy\Build
   ```

4. When prompted for your monitors, enter your amount of monitors

5. When prompted for the folder containing your Lively wallpapers, open:

   **Lively → Settings → General → Wallpaper Directory**

   And use that path.

---

## Configuration

To configure settings, right-click the system tray icon and select **Edit Config**.

This will open `config.json`.

### Configuration Options

| Setting | Description |
|---|---|
| `wallpaper_path` | The folder containing your Lively wallpapers. This must point to Lively's saved wallpaper folder. |
| `delay_seconds` | How often wallpapers change (in seconds). |
| `monitors` | Monitor numbers matching Lively monitor numbering, separated by commas (e.g. `1,2`). |
| `lively_path` | Path to `Lively.exe`. Usually does not need changing, unless Lively has been reinstalled. |
| `dark_mode` | Ignore that for now. Its for later 😏
| `port` | The port the instances communicate on. You do not need to change it unless another program is using it. Which is almost never. |

### Important: Wallpaper Directory

The `wallpaper_folder` setting requires a specific folder path.

To find it:

1. Open Lively.
2. Navigate to **Settings → General**.
3. Click **Wallpaper Directory** and copy that path.

> **IMPORTANT:** The folder shown by Lively is **not** the final folder.

After copying it, append:

```text
\SaveData\wptmp
```

This gives the program the correct directory containing your saved wallpapers.

---

## Logging

Lively Playlist includes a built-in logging system to help track activity, diagnose issues, and understand how the application is behaving behind the scenes.

The log files are automatically generated and stored in the same directory as your configuration file, inside a dedicated `logs` subfolder.

### Opening Logs

To open the log:

1. Right-click the system tray icon.
2. Select **Open Log**.

It will now open the current instance's log in the default text editor.

> **NOTE:** Currently there is only one Mega Log, but in the future it is planned for each instance to have a separate log.

If anything goes wrong or behaves unexpectedly, checking the logs is the first step for debugging or reporting issues.

### Log Format

Each log entry follows this format:

```text
[HASH] YYYY-MM-DD HH:MM:SS [LEVEL] Message
```

The individual components are explained below:

| Component | Description |
|---|---|
| `[HASH]` | The instance hash. It acts as a unique identifier for each running instance of the program, allowing you to tell which instance generated a specific log message. |
| `YYYY-MM-DD HH:MM:SS` | The timestamp showing the exact date and time the log message was created. |
| `[LEVEL]` | The log level identifier, indicating the type or severity of the message. |
| `Message` | The actual log message describing what happened. |

### Log Levels

There are three log levels:

- **INFO** — Normal messages that describe what the application is currently doing.
- **WARNING** — Something is not quite right, but the application can still continue running normally.
- **ERROR** — A failure or serious issue occurred that may affect functionality.

---

## Roadmap

The following roadmap outlines planned improvements and features for future releases.

Features are grouped by their general purpose rather than a specific release version. Development priorities and timelines may change.

### Usability & Interface

- [ ] **Graphical settings window** – A more intuitive way to change the program's settings.
- [ ] **Drag-and-drop wallpaper selection** – Let users select which wallpapers are included/excluded.
- [ ] **Built-in path detection** – Auto-detect Lively install folder, wallpaper folder, and monitors, even for Microsoft Store installs.
- [ ] **Improved logging system** – Separate logs per instance and a global main log for system events, with log rotation to prevent files from growing too large.
- [ ] **Automatic updating** – Automatically update the system and alert the user that the program was updated.

### Core Functionality

- [ ] **Shuffle modes** – Random, sequential, or weighted random playlists.
- [ ] **Per-monitor wallpaper control** – Assign specific wallpapers to certain monitors.
- [ ] **Scheduled changes** – Change wallpapers based on time of day or custom schedule.
- [ ] **Backup & restore settings** – Save user configurations for easy updating.

### Advanced Features

- [ ] **Wallpaper tagging** – Let users tag wallpapers by category and filter which ones appear.
- [ ] **Multi-folder support** – Pull wallpapers from multiple directories.
- [ ] **Weather-based wallpaper mode** – Wallpaper set by category based on weather and time. (User defines wallpapers for each category)
- [ ] **Transition** – Show a certain animation or design when switching wallpapers.

---

## Feedback & Contributions

If you try this project, I'd love to hear what you think.

- 🐛 **Found a bug?** Open an issue.
- 💡 **Have an idea?** Suggest a feature.
- ⭐ **Like the project?** Consider starring it.

---

**Thanks for checking out Lively Wallpaper Playlist!**
