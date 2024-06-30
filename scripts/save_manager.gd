extends Node2D

@export var SAVE_FILE = "user://save.mango"
@export var AUTOSAVE_FREQUENCY = 120 # seconds
@onready var auto_save_timer = $"Auto Save Timer"
@onready var game_manager = %"Game Manager"

func start_autosaving():
	auto_save_timer.start(AUTOSAVE_FREQUENCY)

func save_data_to_disk(updated_game_data):
	print("Saving Data to Disk...")
	var properties_to_save = updated_game_data.get_property_list().filter(GameData.custom_property_filter)
	var save_dict = {}
	for property in properties_to_save:
		save_dict[property.name] = updated_game_data.get(property.name)
	var save_dict_string = JSON.stringify(save_dict, "\t")
	var file =  FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	file.store_string(save_dict_string)
	file.close()
	print("Done.")
	
func load_data_from_disk():
	print("Loading Data From Disk...")
	
	var game_data = GameData.new()
	if not FileAccess.file_exists(SAVE_FILE):
		print("No data to load. Creating blank file...")
		save_data_to_disk(game_data)
		
	var properties_to_load = game_data.get_property_list().filter(GameData.custom_property_filter)
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	var json_content = file.get_as_text()
	var data_dict = JSON.parse_string(json_content)
	for property in properties_to_load:
		game_data.set(property.name, data_dict[property.name])
	file.close()
	print("Done.")
	return game_data

func _on_auto_save_timer_timeout():
	print("Autosaving Game Data...")
	save_data_to_disk(game_manager.game_data)
	auto_save_timer.start(AUTOSAVE_FREQUENCY)
