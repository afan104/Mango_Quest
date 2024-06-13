extends Node

# References to nodes in the scene
@onready var save_manager = $"Save Manager"
@onready var active_level_center = $"Active Level Center"
@onready var player = %Player
@onready var jungle = %Jungle

# Game data variable
var game_data = null

# Called when the node is added to the scene
func _ready():
	load_game_data()
	SignalBus.mango_pickup.connect(add_to_mango_score)
	save_manager.start_autosaving()
	SignalBus.next_level.connect(next_level)

# Loads game data from the save manager
func load_game_data():
	print("Loading Game Data to Manager:")
	game_data = save_manager.load_data_from_disk()
	
	var properties = game_data.get_property_list()
	properties = properties.filter(GameData.custom_property_filter)
	
	for property in properties:
		var property_name = property.name
		var property_value = game_data.get(property_name)
		print("\t%s = %s" % [property_name, property_value])
	
	print("Loading Complete.")
	
func add_to_mango_score():
	game_data.total_mangoes_collected += 1
	print("score: %s" % game_data.total_mangoes_collected)

# Prepares and changes to the next level
func next_level():
	print("Preparing to Change Level")
	jungle.next_level()
	
	# Update positions for active level center and player
	var new_level_center = jungle.current_level.level_center.global_position
	active_level_center.global_position = new_level_center
	player.global_position = new_level_center
	
	print("Changed Level with new center at %s" % new_level_center)

# Called every physics frame
func _physics_process(_delta):
	# Check for debug input to change level
	if Input.is_action_just_released("Next Level (Debug)"):
		SignalBus.next_level.emit()
