extends Area2D

@onready var audio_manager = %"Audio Manager"
@onready var game_manager = %"Game Manager"
@export var id = ""

func _on_body_entered(body):
	SignalBus.mango_pickup.emit()
	queue_free()
