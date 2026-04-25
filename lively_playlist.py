import os
import socket
import sys
import pystray
from pystray import MenuItem as item
from PIL import Image
import threading
import subprocess
import random
import time
import json
import logging

"""
Lively Wallpaper Playlist

This script randomly cycles through saved Lively wallpapers and assigns them to each monitor
based on a configurable interval. Features:

- Runs in the system tray
- Enforces a single running instance
- Randomly chooses wallpapers from subfolders of the specified directory
- Works with multiple monitors
- Configurable via config.json

Code Logic:
1. Setup:
    - Create log file
    - Load config file
2. Single-instance enforcement
    - Check for instance on port
    - Sends quit command if there are
    - Listens for commands from other instances via threading
3. Apply random wallpaper
    - Get a random wallpaper in the wallpaper folder
    - Loop through each monitor and apply that wallpaper
4. Create a system tray icon

Random Wallpaper Selection Logic:
1. Scan the main wallpaper folder for subfolders.
2. Randomly pick one subfolder.
3. Go into that subfolder and find the LivelyInfo.json
4. Use the Lively Wallpaper command-line tool with the LivelyInfo.json to set the wallpaper
5. Repeat for each monitor
6. Repeat every `delay_seconds` as specified in config.json.
"""

# ---------------- Setup ----------------
running = True
random.seed(time.time())

# -----------------------------
#        Create Log
# -----------------------------
os.makedirs("logs", exist_ok=True)

logging.basicConfig(
    filename="logs/lively-shuffle-playlist.log",
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S"
)

# -----------------------------
#        Load config.json
# -----------------------------
config_path = "config.json"
try:
    with open(config_path, "r") as f:
        config = json.load(f)
    logging.info(f"Loaded config from {config_path}")
except Exception as e:
    logging.error(f"Failed to load config file {config_path}: {e}")
    sys.exit(1)

lively_path = os.path.expandvars(config.get("lively_path"))
delay = config.get("delay_seconds", 1800)
wallpaper_folder = os.path.expandvars(config.get("wallpaper_folder"))
monitors = config.get("monitors", [1])

PORT = 47200
instance_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM) 

# ---------------- Prevent multiple instances running ----------------
def prevent_instances():
    # Check for any other instances on port
    try:
        instance_socket.bind(("127.0.0.1", PORT))
        instance_socket.listen(5)

    except OSError:
        logging.info("Instance already running. Sending quit command")

        # Send quit command to the instance
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.connect(("127.0.0.1", PORT))
            s.sendall(b"quit") # Send the quit command
            s.close()
        except:
            logging.error("Could not contact running instance")
        
        # Wait until the instance has shutdown
        for _ in range(20):
            try:
                instance_socket.bind(("127.0.0.1", PORT))
                instance_socket.listen(5)
                logging.info("Successfully shut down first instance")
                break
            except OSError:
                time.sleep(0.2)

# Listen for commands from other instances
def command_listener():
    """
    Listens for any commands on the port
    If so it ends the instance

    """
    global running

    while running:
        try:
            conn, _ = instance_socket.accept()
            cmd = conn.recv(1024).decode().strip()

            if cmd == "quit":
                running = False
                icon.stop()
            
            conn.close()
        except Exception:
            pass

# Add the listener to a thread so it can run while the rest of the script is running
prevent_instances()
threading.Thread(target=command_listener, daemon=True).start()

# ---------------- Shuffle wallpapers ----------------

# -----------------------------
#   Pick a random wallpaper
# -----------------------------
def get_random_wallpaper(folder):
    """
    Scans the given folder for subfolders and returns the path
    to one randomly chosen wallpaper subfolder.
    
    Args:
        folder (str): The main wallpaper directory.

    Returns:
        str or None: Path to a random wallpaper subfolder, or None if none exist.
    """
    if not os.path.exists(folder):
        logging.error(f"Wallpaper folder not found: {folder}")
        return None
    
    folders = [
        os.path.join(folder, f)
        for f in os.listdir(folder) # List all the folders
        if os.path.isdir(os.path.join(folder, f)) # Only include directories
    ]

    if not folders:
        logging.warning(f"No wallpaper folders found in {folder}")
        return None
    
    wallpaper = random.choice(folders) # Randomly pick a folder
    logging.info(f"Selected wallpapers: {wallpaper}")

    return wallpaper

# ------------------------------------------
#  Apply a random wallpaper to each monitor
# ------------------------------------------
def wallpaper_shuffler():
    """
    Applies a random wallpaper for each monitor
    """
    while True:
        for monitor in monitors:
            wallpaper = get_random_wallpaper(wallpaper_folder)

            if wallpaper:
                # Runs the lively command line tool and uses the LivelyInfo.json as the wallpaper, allowing it to load local and web wallpapers
                try:
                    subprocess.run([
                        lively_path,
                        "setwp",
                        "--file", wallpaper,
                        "--monitor", str(monitor)
                    ],
                    creationflags=subprocess.CREATE_NO_WINDOW, # Stops a terminal window being spawned
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.DEVNULL,
                    check=True
                    )
                except subprocess.CalledProcessError as e:
                    logging.error(f"Failed to set wallpaper {wallpaper} on monitor {monitor}: {e}")

        # Wait for a delay before running again
        for _ in range(delay):
            if not running:
                return
            time.sleep(1)


# ---------------- System Tray ----------------
def on_quit(icon):
    """
    Closes the network socket and stops the system tray icon.
    """
    global running
    running = False
    instance_socket.close()
    icon.stop()

def open_config():
    """
    Opens the config.json file with the default system editor
    """
    try:
        os.startfile("config.json")  # Windows: opens file with default program
    except Exception as e:
        logging.error(f"Failed to open config.json: {e}")

def next_wallpaper():
    threading.Thread(target=wallpaper_shuffler, daemon=True).start()

# -----------------------------
#        Load the icon
# -----------------------------
try:
    icon_image = Image.open("icon.ico")
    logging.info("Loaded tray icon successfully")
except Exception as e:
    logging.error(f"Failed to load tray icon: {e}")
    sys.exit(1)

# Starts the wallpaper shuffler in a background thread
threading.Thread(target=wallpaper_shuffler, daemon=True).start()

# -----------------------------
#        Create the icon
# -----------------------------
icon = pystray.Icon(
    "LivelyPlaylist",
    icon_image, 
    "Lively Playlist", 
    menu=pystray.Menu(
        item("Open Config", open_config),
        item("Quit", on_quit),
        item("Next Wallpaper", next_wallpaper)
    )
)

# Run the tray icon
try:
    icon.run()
except KeyboardInterrupt:
    running = False
    instance_socket.close()