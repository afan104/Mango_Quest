extends Node2D

@onready var l1_background_music = $"L1 Background Music"
@onready var mango_pickup = $"Mango Pickup"

var audio_callback_map = {}

func initialize_callback_map():
	# Signal : [Audio Stream, Should Loop]
	audio_callback_map[SignalBus.l1_background_music] = [l1_background_music, true]
	audio_callback_map[SignalBus.mango_pickup] = [mango_pickup, false]

func _ready():
	initialize_callback_map()
	register_callbacks()

func register_callbacks():
	for audio_signal in audio_callback_map:
		var stream =  audio_callback_map[audio_signal][0]
		var loop = audio_callback_map[audio_signal][1]
		print("Registering signal %s to stream %s" % [audio_signal.get_name(), stream.name])
		register_callback(audio_signal, stream, loop)
		print("Registered Successfully")


func register_callback(audio_signal, stream, loop):
	audio_signal.connect(stream.play)
	if (loop):
		stream.finished.connect(stream.play)
		
	
	
