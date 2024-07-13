extends Node2D

# Paths to level scenes in order of loading (1,2, 3, ...)
@onready var levels = [
	"res://scenes/regions/jungle/level_1.tscn",
	"res://scenes/regions/jungle/level_2.tscn",
	"res://scenes/regions/jungle/level_1.tscn",
	"res://scenes/regions/jungle/level_2.tscn",
]

# Directions for level transitions. The level fade effect will
# follow this direction. For example: vector2.RIGHT means the
# level will spawn on the right and the camera will slowly move
# right until it is showing the full level.
@onready var level_transitions = [
	Vector2.ZERO,
	Vector2.RIGHT,
	Vector2.UP,
	Vector2.DOWN,
]

# Initial level number
@onready var current_level_no = 1

# Offset for level generation position
const LEVEL_GEN_OFFSET = 128

# Currently loaded level
var current_level

# Called when the node is added to the scene
func _ready():
	load_level()

# Loads the next level if available
func next_level():
	if current_level_no < levels.size():
		current_level_no += 1
		load_level()

# Loads the current level based on `current_level_no`
func load_level():
	var level_idx = current_level_no - 1
	var previous_level = current_level
	
	var previous_level_position = Vector2.ZERO
	if previous_level:
		previous_level_position = previous_level.global_position
	
	current_level = load(levels[level_idx]).instantiate()
	var transition_direction = level_transitions[level_idx]
	
	var new_position = previous_level_position + transition_direction * LEVEL_GEN_OFFSET
	current_level.global_position = new_position
	
	add_child(current_level)
	
	if previous_level:
		previous_level.queue_free()
		
	SignalBus.level_ready.emit()
