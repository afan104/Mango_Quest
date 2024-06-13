extends Area2D


@onready var timer = $Timer
var slowed_time_scale = 0.5
var default_time_scale = 1

func _on_body_entered(body):
	print("You died...")
	Engine.time_scale = slowed_time_scale
	body.get_node("CollisionShape2D").queue_free()
	timer.start()
	

func _on_timer_timeout():
	Engine.time_scale = default_time_scale
	get_tree().reload_current_scene()
