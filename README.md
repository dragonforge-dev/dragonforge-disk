[![Static Badge](https://img.shields.io/badge/Godot%20Engine-4.5.stable-blue?style=plastic&logo=godotengine)](https://godotengine.org/)
[![License](https://img.shields.io/github/license/dragonforge-dev/dragonforge-disk?logo=mit)](https://github.com/dragonforge-dev/dragonforge-disk/blob/main/LICENSE)
[![GitHub release badge](https://badgen.net/github/release/dragonforge-dev/dragonforge-disk/latest)](https://github.com/dragonforge-dev/dragonforge-disk/releases/latest)
[![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/dragonforge-dev/dragonforge-disk)](https://img.shields.io/github/languages/code-size/dragonforge-dev/dragonforge-disk)

# Dragonforge Disk (Save/Load) <img src="/addons/dragonforge_disk/assets/textures/icons/floppy-disk-red.svg" width="32" alt="Disk Icon"/>
An Autoload singleton to handle saving and loading of game data and settings.

# Version 0.6
For use with **Godot 4.5.stable** and later.

# Installation Instructions
1. Copy the `dragonforge_disk` folder from the `addons` folder into your project's `addons` folder.
2. In your project go to **Project -> Project Settings...**
3. Select the **Plugins** tab.
4. Check the **On checkbox** under **Enabled** for **Dragonforge Disk (Save/Load)**
5. Press the **Close** button.

# Usage Instructions
Using this plugin is very straightforward. 
## Autosave on Quit
To turn on autosave when the player quits, do the following:
1. Open the `disk.tscn` scene in your project's `addons/dragonforge_disk` folder.
2. In the **Inspector**, check the **Save on Quit** box labeled **On**.
3. Save and close the scene.
Every time the game closes it will be saved. Note that if you call `get_tree().quit()` in your code, you must put this line before it or no autosave will happen: `get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)` Note that if the user quits by pressing the X button in the window, or closing the app on a mobile devies, the autosave **will** be called.
## Saving the Game <img src="/assets/textures/icons/floppy-disk-green-save-game.svg" width="32" alt="Disk Icon"/>
Call `Disk.save_game()` to save the entrie game. To add values to be saved for a **Node**, add a node to the **Persist** Global Group on the **Nodes** tab. Then implement `save_node()` and `load_node()` functions. The first function should return a value to store, and the second should use that value to load the information. If you need to store multiple values, use a dictionary or changes later will result in save/load errors. 
**NOTE:** The node name must be unique or data will get overwritten.
## Loading the Game <img src="/assets/textures/icons/floppy-disk-blue.svg" width="32" alt="Disk Icon"/>
Call `Disk.load_game()` to load the entire game. Every node will load its own value.  To add a node to be loaded, implement a `load_node()` function for the node. It should use the passed value(s) to configure the node. 
**NOTE:** The node name must be unique or data will get overwritten.
## Saving a Setting <img src="/assets/textures/icons/floppy-disk-green-save-settings.svg" width="32" alt="Disk Icon"/>
Call `Disk.save_setting(setting_data, setting_name)` where the `setting_data` is either a single variable of any type or a **Dictionary** object containing ultiple setting values. The `setting_name` should be a unique **String** or **StringName** that can be used to retrieve the value.
## Loading a Setting <img src="/assets/textures/icons/floppy-disk-settings-blue.svg" width="32" alt="Disk Icon"/>
Call `var setting_data = Disk.load_setting(setting_name)` where `setting_data` is the variable you want to load the value into and `setting_name` is the **String** or **StringName** the setting was originally stored under.

# Class Descriptions
## Disk (Autoload) <img src="/addons/dragonforge_disk/assets/textures/icons/floppy-disk-red.svg" width="32" alt="Disk Icon"/>
This autoload allows you to access all the features of this plugin. It allows you to create a settings file for user settings, and a save game file. Currently multiple save game files are not supported, but the user can easily add that support themselves.
### Constants
- `SETTINGS_PATH` All settings are hardcoded to be stored in `user://configuration.settings`. You can change that by editing this constant.
- `SAVE_GAME_PATH` The save game file is hardcoded to be stored in `user://game.save`. You can change that by editing this constant.
### Export Variables
- `settings_path: String = DEFAULT_SETTINGS_PATH` The path to save all settings.
- `save_game_path: String = DEFAULT_SAVE_GAME_PATH` The path to save all game data.
- `save_on_quit: bool = false` If this value is On/`true`, `save_game()` will be called when the player quits the game. Defaults to off.
### Public Functions
- `save_game() -> bool` Returns true if the save was successful, otherwise false. Calls every node added to the Persist Global Group to save data. Works by calling every node in the group and running its `save_node()` function, then storing everything in the save file. If a node is in the group, but didn't implement the `save_node()` function, it is skipped.
- `load_game() -> void` Call this to call the `load_node()` function for every node in the **Persist** Global Group. The save game, if it exists, will be loaded from disk and the values propagated to the game objects.
- `save_setting(data: Variant, category: String) -> void` Stores the passed data under the indicated settings catergory.
- `load_setting(category: String) -> Variant` Returns the stored data for the passed setting category.
