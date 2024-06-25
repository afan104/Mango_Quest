extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var audio_manager = %"Audio Manager"
@onready var ray_cast_2d = $RayCast2D

# Handles gravity (default setting: 980)
var gravity = 2500

# Stores jump collisions
var collision_shapes_pos = {"default" = Vector2(0.5, 0.5),
							"jump_0" = Vector2(0.5, -2.5), 
							"jump_1" = Vector2(0.5, 0.07)}
var collision_shapes_scale = {"default" = Vector2(1.67, 1),
							 "jump_0" = Vector2(1.67, 1), 
							 "jump_1" = Vector2(1.67, 1.07)}
				
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	# Handles animation
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			animated_sprite_2d.animation = "jump"
			animated_sprite_2d.play()
		elif direction != 0:
			animated_sprite_2d.animation ="run"
			animated_sprite_2d.play()
		else:
			animated_sprite_2d.animation = "idle"
			animated_sprite_2d.play()
		# TODO: Get animation death once reaches killzone
	else:
		if animated_sprite_2d.animation == "jump":
			# Change collision shape for jump
			if animated_sprite_2d.frame == 0:
				collision_shape_2d.position = collision_shapes_pos["jump_0"]
				collision_shape_2d.scale = collision_shapes_scale["jump_0"]
			# stop looping
			if animated_sprite_2d.frame == 1:
				collision_shape_2d.position = collision_shapes_pos["jump_1"]
				collision_shape_2d.scale = collision_shapes_scale["jump_1"]
				animated_sprite_2d.pause()
			# trigger landing
			if (ray_cast_2d.is_colliding()) and (velocity.y >= 0):
				animated_sprite_2d.animation = "land"
				collision_shape_2d.position = collision_shapes_pos["default"]
				collision_shape_2d.scale = collision_shapes_scale["default"]
		else:
			animated_sprite_2d.animation = "land"
	
	# Handles speed	
	if direction:
		velocity.x = direction * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	

