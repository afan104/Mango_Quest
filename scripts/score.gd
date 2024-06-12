extends RichTextLabel

@onready var score = $"."
@onready var timer = $"../Timer"
@onready var game_manager = $"../../Game Manager"
var mangoes = 0

func _ready():
	SignalBus.mango_pickup.connect(display_score)

func display_score():
	"""displays mango count"""
	score.visible = true
	timer.start()
	mangoes += 1
	var t = "\n\tMangoes: %s" % mangoes
	#score.text = "[wave amp=50.0 freq=5.0 connected=1][rainbow freq=0.5 sat=0.8 val=0.8]" + t + "[/rainbow][/wave]"
	score.text = "[shake rate=20.0 level=50 connected=0]" + t + "[/shake]"

func _on_timer_timeout():
	score.visible = false
