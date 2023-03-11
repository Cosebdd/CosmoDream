extends KinematicObject

onready var animated_sprite := $AnimatedSprite

func _physics_process(_delta):
	apply_gravity()
	
	var input = Vector2.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	
	animated_sprite.flip_h = input.x < 0
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			jump()
	else:
		animated_sprite.play("Jump")
		if Input.is_action_just_released("jump") and velocity.y <= -min_jump_height:
			velocity.y = -min_jump_height
	
		handle_body_in_air()
	
	process(input)
	
	if input.x == 0 and velocity.x == 0:
		animated_sprite.play("idle")
