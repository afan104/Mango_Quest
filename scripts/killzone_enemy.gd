extends Area2D


@onready var timer = $Timer


func _on_body_entered(body):
	print("body entered")
	#Engine.time_scale = 0.5
	SignalBus.killed_by_enemy.emit()
	timer.start()
	

func _on_timer_timeout():
	#Engine.time_scale = 1
	get_tree().reload_current_scene()
