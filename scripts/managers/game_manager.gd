extends Node

# References to nodes in the scene
@onready var save_manager = $"Save Manager"
@onready var player = %Player
@onready var jungle = %Jungle
@onready var active_focus_zone = %"Active Focus Zone"

# Game data variable
var game_data = null

# Called when the node is added to the scene
func _ready():
	load_game_data()
	save_manager.start_autosaving()
	
	SignalBus.mango_pickup.connect(add_to_mango_score)
	SignalBus.next_level.connect(next_level)
	SignalBus.change_focus.connect(change_camera_focus)
	SignalBus.level_ready.connect(load_player_at_current_spawn)

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

func load_player_at_current_spawn(spawn):
	player.set_player_pos(spawn.global_position)

func change_camera_focus(focal_point):
	active_focus_zone.position = focal_point
	
# Prepares and changes to the next level
func next_level():
	jungle.next_level()

# Called every physics frame
func _physics_process(_delta):
	# Check for debug input to change level
	if Input.is_action_just_released("Next Level (Debug)"):
		SignalBus.next_level.emit()
