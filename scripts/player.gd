extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0

@onready var audio_manager = %"Audio Manager"
@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var ray_cast_2d = $RayCast2D

# Handles gravity (default setting: 980)
var gravity = 2500

func _ready():
	SignalBus.killed_by_enemy.connect(death)

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
		sprite_2d.flip_h = false
	elif direction < 0:
		sprite_2d.flip_h = true
	
	# Handles animation
	animate(direction)
	
	# Handles speed	
	if direction:
		velocity.x = direction * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func death():
	print("killed")
	# death animation and then activate killzone
	animation_player.play("death")
	set_process_input(false)

func animate(direction):
	if is_on_floor():
		if Input.is_action_just_pressed("jump"): 
			animation_player.play("jump",-1,4)
		elif direction != 0: 
			animation_player.play("run")
		else: 
			animation_player.play("idle")
	else:
		if (velocity.y >= 0) and (not ray_cast_2d.is_enabled() or ray_cast_2d.is_colliding()):
			animation_player.play("land")
