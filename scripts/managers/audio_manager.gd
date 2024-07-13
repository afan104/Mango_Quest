extends Node2D

# Reference to the background music node
@onready var l1_background_music = $"L1 Background Music"
@onready var mango_pickup = $"Mango Pickup"

@onready var audio_callback_map = {
	SignalBus.l1_background_music: [l1_background_music, true],
	SignalBus.mango_pickup: [mango_pickup, false]
}

func _ready():
	register_callbacks()

# Registers callbacks for each signal in the callback map
func register_callbacks():
	for audio_signal in audio_callback_map:
		var stream = audio_callback_map[audio_signal][0]
		var loop = audio_callback_map[audio_signal][1]
		
		print("Registering signal %s to stream %s" % [audio_signal.get_name(), stream.name])
		register_callback(audio_signal, stream, loop)
		print("Registered Successfully")

# Registers a single callback for the given signal, stream, and loop setting
func register_callback(audio_signal, stream, loop):
	# Connect the audio signal to the stream's play method
	audio_signal.connect(stream.play)
	
	# If looping is enabled, connect the stream's finished signal to its play method
	if loop:
		stream.finished.connect(stream.play)
