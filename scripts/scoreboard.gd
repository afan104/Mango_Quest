extends CanvasLayer

@onready var score = $"Score"
@onready var timer = $"Timer"
@onready var game_manager = %"Game Manager"

# For text effects
const START_EFFECT = "[shake rate=20.0 level=50 connected=0]"
const END_EFFECT = "[/shake]"

func _ready():
	SignalBus.mango_pickup.connect(display_score)

func display_score():
	#"""displays mango count"""
	score.visible = true
	timer.start()
	
	# Print score with text effects
	var t = "Mangoes: %s" % game_manager.game_data.total_mangoes_collected
	score.text =  START_EFFECT + t + END_EFFECT

func _on_timer_timeout():
	score.visible = false
