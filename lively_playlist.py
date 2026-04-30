import os
from pathlib import Path
import socket
import sys
import pystray
from PIL import Image
import threading
import subprocess
import random
import time
import json
import logging
import uuid

"""
Lively Wallpaper Playlist

This script randomly cycles through saved Lively wallpapers and assigns them to each monitor
based on a configurable interval. Features:

- Runs in the system tray
- Automatically detects when config changes and applies new settings without needing to restart
- Uses the Lively Wallpaper command-line tool to set wallpapers, allowing it to work with both local and web wallpapers saved in Lively
- Logs all actions and errors to a log file with a unique instance ID for easier debugging when multiple instances are accidentally opened
- Enforces a single running instance
- Randomly chooses wallpapers from subfolders of the specified directory
- Easy shutdown and restart of the wallpaper shuffling thread when config changes or when the user clicks "Next Wallpaper" in the menu
- Works with multiple monitors
- Configurable via config.json

The classes are designed to be modular and communicate with each other as needed, with the AppController managing the overall flow and interactions between components. 
The IPCManager ensures that only one instance of the application is running at a time, 
while the WallpaperEngine handles all wallpaper-related logic and the UIManager manages the system tray icon and user interactions. 
The ConfigManager handles loading and saving configuration settings, as well as opening the config file in the default text editor when requested by the user.

Code Logic:
1. Main():
    - Initializes the AppController, which sets up the IPC manager, config manager, wallpaper engine, and UI manager.
2. AppController:
    - Manages the overall application flow and communication between components.
    - Setups the configuration as well as creating logging with a unique instance ID for easier debugging.
    - Starts the IPC listener thread, wallpaper shuffling thread, and system tray UI.
2. IPCManager:
    - Check for instance on port 65432 to enforce single instance
    - Sends quit command if there are other instances and waits for them to shut down before allowing the new instance to start up.
    - Listens for commands from other instances and shuts down if it receives a quit command
3. WallpaperEngine:
    - Get a random wallpaper in the wallpaper folder
    - Loop through each monitor and apply that wallpaper
    - Wait for the specified delay and repeat
    - Easily shutdown and restart the wallpaper shuffling thread when config changes or when the user clicks "Next Wallpaper" in the menu
4. Create a system tray icon
    - Menu options to open config, quit, and next wallpaper

Random Wallpaper Selection Logic:
1. Scan the main wallpaper folder for subfolders.
2. Randomly pick one subfolder.
3. Go into that subfolder and find the LivelyInfo.json
4. Use the Lively Wallpaper command-line tool with the LivelyInfo.json to set the wallpaper
5. Repeat for each monitor
6. Repeat every `delay_seconds` as specified in config.json.

Due to the new features and improvements, the code is more modular and easier to maintain, with clear separation of concerns between different components.
Please note that due to the sudden change of code structure there may be some bugs or edge cases that were not accounted for, so please let me know if you encounter any issues or have any suggestions for improvement!
"""

class AppController:
    def __init__(self):
        self.vars = self.configure()
        self.port = self.vars["PORT"]

        # Initialize the IPC manager, config manager, wallpaper engine, and UI manager with the appropriate variables and configurations. 
        # As well as passing the clases to each other as needed for callbacks and communication.
        self.instance = IPCManager(self.port)
        self.config = ConfigManager(self.vars["config_path"])
        self.engine = WallpaperEngine(self.config)
        self.ui = UIManager(self.engine, self.config)

    def start(self):
        """Starts the application by starting the IPC listener thread, wallpaper shuffling thread, and system tray UI."""
        threading.Thread(target=self.instance.listen, daemon=True).start()
        threading.Thread(target=self.instance.enforce_single_instance, daemon=True).start()
        threading.Thread(target=self.engine.start, daemon=True).start()
        self.ui.setup()
        self.ui.start()

    def stop(self):
        """Stops the application by stopping the UI, wallpaper engine, and then exiting the program."""
        self.ui.stop()
        self.engine.stop()
        sys.exit(0)
    
    def configure(self):
        random.seed(time.time())
        # ---------------- Find paths based on if it is in executable form or script form ----------------

        # Set the bool based on if it is frozen (executable) or not (script)
        program_state = 0 if getattr(sys, 'frozen', False) else 1
        base_dir = Path(__file__).parent

        # Set the paths based on the program state
        if program_state == 0:
            appdata = Path(os.getenv("APPDATA")) / "LivelyPlaylist"
            if appdata is None:
                raise RuntimeError("APPDATA not found")
            logs_dir = appdata / "logs"
            config_path = appdata / "config.json"
        elif program_state == 1:
            logs_dir = base_dir / "logs"
            config_path = base_dir / "config.json"

        # ---------------- Setup Logging ----------------
        logs_dir.mkdir(parents=True, exist_ok=True)

        # Create a unique instance ID for logging (combination of process ID and random UUID)
        instance_id = f"{os.getpid()}-{uuid.uuid4().hex[:6]}"

        # Create log file
        logging.basicConfig(
            filename=logs_dir / "lively-playlist.log",
            level=logging.INFO,
            format=f"[{instance_id}] %(asctime)s [%(levelname)s] %(message)s",
            datefmt="%Y-%m-%d %H:%M:%S"
        )

        logging.info("\n-----------------------------\nApplication started\n-----------------------------")
        logging.info(
            f"Startup | mode={'EXE' if program_state == 0 else 'SCRIPT'} | "
            f"base_dir={base_dir} | logs_dir={logs_dir}"
        )

        # Return all the important variables for the app
        return {
            "program_state": program_state,
            "base_dir": base_dir,
            "logs_dir": logs_dir,
            "config_path": config_path,
            "PORT": 65432
        }

class WallpaperEngine:
    """Class that manages the wallpaper shuffling logic and interacts with the Lively Wallpaper command line tool."""
    def __init__(self, config_manager=None):
        self.thread = None
        self.running = False

        # Load config
        self.config = config_manager.load()
        self.monitors = self.config["monitors"]
        self.wallpaper_folder = self.config["wallpaper_folder"]
        self.lively_path = self.config["lively_path"]
        self.delay = self.config["delay"]

    def start(self):
        """Starts the wallpaper shuffling thread."""
        if self.running:
            logging.warning("Wallpaper shuffler is already running.")
            return
        
        self.running = True

        self.thread = threading.Thread(
            target=self._loop, 
            daemon=True
        )
        self.thread.start()
        logging.info("Started wallpaper shuffler thread.")

    def stop(self):
        """Stops the wallpaper shuffling thread."""
        self.running = False
        self.running = False

        if self.thread:
            self.thread.join(timeout=5)
            logging.info("Stopped wallpaper shuffler thread.")

    def get_wallpaper(self, folder):
        """Find wallpapers in the wallpaper folder and randomly pick one, then return the path to the wallpaper."""
        folder = Path(folder)
        if not folder.is_dir():
            logging.error(f"Wallpaper folder not found: {folder}")
            return None
        
        # List all the subfolders in the wallpaper folder, as each wallpaper is stored in its own folder with a LivelyInfo.json
        folders = [
            folder / f
            for f in os.listdir(folder)
            if (folder / f).is_dir() # Only include directories
        ]

        if not folders:
            logging.warning(f"No wallpaper folders found in {folder}")
            return None
        
        # Randomly pick a folder
        wallpaper = random.choice(folders)
        logging.info(f"Selected wallpapers: {wallpaper}")

        return wallpaper

    def _loop(self):
        """Main loop that shuffles wallpapers at the specified interval."""
        while self.running:
            logging.info(f"Shuffling new wallpapers from {self.wallpaper_folder}...")
            for monitor in self.monitors:
                wallpaper = self.get_wallpaper(self.wallpaper_folder)

                if wallpaper:
                    # Runs the lively command line tool and uses the LivelyInfo.json as the wallpaper, allowing it to load local and web wallpapers
                    try:
                        subprocess.run([
                            self.lively_path,
                            "setwp",
                            "--file", wallpaper,
                            "--monitor", str(monitor)
                        ],
                        logging.info(f"Setting wallpaper {wallpaper} on monitor {monitor}"),
                        creationflags=subprocess.CREATE_NO_WINDOW, # Stops a terminal window being spawned
                        stdout=subprocess.DEVNULL,
                        stderr=subprocess.DEVNULL,
                        check=True
                        )
                    except subprocess.CalledProcessError as e:
                        logging.error(f"Failed to set wallpaper {wallpaper} on monitor {monitor}: {e}")

            # Wait for a delay before running again
            logging.info(f"Waiting for {self.delay} seconds before next shuffle...")
            for _ in range(self.delay):
                if not self.running:
                    return
                time.sleep(1)

    def restart(self):
        """Restarts the wallpaper shuffling thread with the new config values."""
        logging.info("Restarting wallpaper shuffler with new config...")
        self.stop()
        self.start(self.monitors, self.wallpaper_folder, self.lively_path, self.delay)

    def listen_for_config_changes(self, config_path):
        """
        Listens for changes to the config file and calls the callback when it changes.
        """
        last_modified = os.path.getmtime(config_path)
        while True:
            time.sleep(1)
            try:
                current_modified = os.path.getmtime(config_path)
                if current_modified != last_modified:
                    logging.info("Config file changed, reloading...")
                    last_modified = current_modified
                    self.restart()
            except Exception as e:
                logging.error(f"Error watching config file: {e}")

class ConfigManager:
    """
    Class that manages loading and saving the config file, as well as providing access to config values. 
    It also expands environment variables in the paths when loading the config.
    """
    def __init__(self, path):
        self.path = Path(path)
        self.config = None

    def load(self):
        """Loads the config file and expands any environment variables in the paths, then returns the config as a dictionary."""
        with open(self.path, "r", encoding="utf-8") as f:
            raw = json.load(f)
        
        logging.info(f"Loaded config from {self.path}")
        # Expand environment variables in paths
        raw["lively_path"] = os.path.expandvars(raw.get("lively_path", ""))
        raw["wallpaper_folder"] = os.path.expandvars(raw.get("wallpaper_folder", ""))

        raw["delay"] = raw.get("delay_seconds", 1800)
        raw["monitors"] = raw.get("monitors", [1])
        
        self.config = raw
        return self.config
    
    def save(self):
        """Saves the current config to the config file."""
        if self.config is None:
            logging.warning("No config to save.")
            return
        
        with open(self.path, "w", encoding="utf-8") as f:
            json.dump(self.config, f, indent=4)

    def open(self):
        """Opens the config file in the default text editor."""
        os.startfile(self.path)
        logging.info(f"Opened config at {self.path}")

    def get(self, key, default=None):
        """Gets a config value by key, with an optional default if the key is not found."""
        return self.config.get(key, default)

# Class that manages the system tray icon and menu, as well as user interactions with the menu
class UIManager:
    def __init__(self, engine, config_manager):
        self.engine = engine
        self.config_manager = config_manager
        self.icon = None
        self.config = config_manager.load()

    def start(self):
        """Starts the system tray icon and menu."""
        logging.info("Starting tray icon.")
        # Run the tray icon
        try:
            self.icon.run()
        except KeyboardInterrupt:
            self.engine.running = False
            self.config["instance_socket"].close()

    def stop(self):
        """Stops the system tray icon and menu, and closes the network socket."""
        logging.info("Shutting down application...")
        self.engine.running = False
        self.icon.stop()

    def next_wallpaper(self):
        """
        Callback for when the 'Next Wallpaper' menu item is clicked,
        which restarts the wallpaper shuffling thread to immediately shuffle to new wallpapers.
        """
        self.engine.stop()
        self.engine.start()
    
    def setup(self):
        """Sets up the system tray icon and menu, and loads the icon image from the file system."""
        # Load the tray icon image
        try:
            icon_image = Image.open("icon.ico")
            logging.info("Loaded tray icon successfully")
        except Exception as e:
            logging.error(f"Failed to load tray icon: {e}")
            sys.exit(1)

        # Create the tray icon and menu
        self.icon = pystray.Icon(
            "LivelyPlaylist",
            icon_image, 
            "Lively Playlist", 
            menu=pystray.Menu(
                pystray.MenuItem("Open Config", lambda: self.config_manager.open()),
                pystray.MenuItem("Quit", lambda: self.stop()),
                pystray.MenuItem("Next Wallpaper", lambda: self.next_wallpaper())
            )
        )

        logging.info("Tray icon and menu set up successfully")
    
class IPCManager:
    def __init__(self, port):
        # Socket for single-instance enforcement and inter-process communication
        self.port = port
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM) 

    def enforce_single_instance(self):
        """
        Enforces that only a single instance of the application is running by trying to bind to a specific port. 
        If it fails, it sends a quit command to the existing instance 
        and waits for it to shut down before allowing the new instance to continue starting up.
        """

        # Check for any other instances on port
        try:
            self.socket.bind(("127.0.0.1", self.port))
            self.socket.listen(5)
            logging.info("No other instances detected. Continuing startup.")

        except OSError:  
            self.send_command("quit") # Send quit command to the instance
            # Wait until the instance has shutdown
            for _ in range(20):
                try:
                    self.socket.bind(("127.0.0.1", self.port))
                    self.socket.listen(5)
                    logging.info("Successfully shut down first instance. Continuing startup")
                    break
                except OSError:
                    time.sleep(0.2)

    def send_command(self, cmd):
            logging.info("Instance already running. Sending quit command...")

            # Send command to the instance
            try:
                s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                s.connect(("127.0.0.1", self.port))
                s.sendall(cmd) # Send command
                s.close()
                logging.info("Command sent to running instance.")
            except:
                logging.error("Could not contact running instance. It may not have shut down properly. Please manually close running instances and try again.")

    # Listen for commands from other instances
    def listen(self):
        """
        Listens for commands from other instances on a separate thread. 
        The only command currently implemented is "quit", which will trigger the application to shut down.

        """
        while True:
            try:
                conn, _ = self.socket.accept()
                cmd = conn.recv(1024).decode().strip()
                
                logging.info(f"Received command: {cmd}")
                # Handle the command
                if cmd == "quit":
                    # Stop the application via the AppController.stop method, which will cleanly shut down all threads and exit the application
                    AppController.stop(self)
                    logging.info("Shutting down instance due to quit command.")
                conn.close()
            except Exception:
                pass

def main(): 
    app = AppController()
    app.start()

if __name__ == "__main__":
    main()