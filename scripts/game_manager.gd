extends Node

@onready var save_manager = %"Save Manager"
var game_data = null

func _ready():
	load_game_data()
	SignalBus.mango_pickup.connect(add_to_mango_score)
	save_manager.start_autosaving()

func load_game_data():
	print("Loading Game Data to Manager: ")
	game_data = save_manager.load_data_from_disk()
	var properties = game_data.get_property_list().filter(GameData.custom_property_filter)
	for property in properties:
		print("\t%s = %s" % [property.name, game_data.get(property.name)])
	print("Loading Complete.")
	
func add_to_mango_score():
	game_data.total_mangoes_collected += 1
	print("score: %s" % game_data.total_mangoes_collected)
