extends Area2D

func _on_body_entered(_body):
	# Emit a signal with the zone's position
	SignalBus.change_focus.emit(global_position)
