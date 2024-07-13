extends Node2D

# Exported variables for save file location and autosave frequency
@export var SAVE_FILE = "user://save.mango"
@export var AUTOSAVE_FREQUENCY = 120 # seconds

# References to nodes in the scene
@onready var auto_save_timer = $"Auto Save Timer"
@onready var game_manager = %"Game Manager"

# Starts the autosaving process with the specified frequency
func start_autosaving():
	auto_save_timer.start(AUTOSAVE_FREQUENCY)

# Saves the updated game data to disk
func save_data_to_disk(updated_game_data):
	print("Saving Data to Disk...")
	
	# Get properties to save using a custom filter
	var properties_to_save = updated_game_data.get_property_list().filter(GameData.custom_property_filter)
	var save_dict = {}
	
	# Create a dictionary of properties to save
	for property in properties_to_save:
		save_dict[property.name] = updated_game_data.get(property.name)
	
	# Convert dictionary to JSON string with indentation
	var save_dict_string = JSON.stringify(save_dict, "\t")
	
	# Open file and store JSON string
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	file.store_string(save_dict_string)
	file.close()
	
	print("Saved to disk.")

# Loads game data from disk
func load_data_from_disk():
	print("Loading Data From Disk...")
	
	var game_data = GameData.new()
	
	# Check if the save file exists
	if not FileAccess.file_exists(SAVE_FILE):
		print("No data to load. Creating blank file...")
		save_data_to_disk(game_data)
		return game_data
	
	# Get properties to load using a custom filter
	var properties_to_load = game_data.get_property_list().filter(GameData.custom_property_filter)
	
	# Open file and read JSON content
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	var json_content = file.get_as_text()
	var data_dict = JSON.parse_string(json_content)
	
	# Set game data properties from loaded data
	for property in properties_to_load:
		game_data.set(property.name, data_dict[property.name])
	
	file.close()
	print("Loaded from disk.")
	
	return game_data

# Handles the auto-save timer timeout signal
func _on_auto_save_timer_timeout():
	print("Autosaving Game Data...")
	save_data_to_disk(game_manager.game_data)
	auto_save_timer.start(AUTOSAVE_FREQUENCY)
