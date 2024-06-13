extends CanvasLayer

@onready var score = $"Score"
@onready var timer = $"Timer"
@onready var game_manager = %"Game Manager"

func _ready():
	SignalBus.mango_pickup.connect(display_score)

func display_score():
	#"""displays mango count"""
	score.visible = true
	timer.start()
	
	# Print score with text effects
	var t = "Mangoes: %s" % game_manager.game_data.total_mangoes_collected
	var start_effect = "[shake rate=20.0 level=50 connected=0]"
	var end_effect = "[/shake]"
	score.text =  start_effect + t + end_effect

func _on_timer_timeout():
	score.visible = false
