extends KinematicObject

onready var animation_player := $AnimationPlayer
onready var body := $Body

func _physics_process(_delta):
	apply_gravity()
	
	var input = Vector2.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	
	if input.x < 0: body.scale.x = -1
	if input.x > 0: body.scale.x = 1
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			jump()
	else:
		animation_player.play("Jump")
		if Input.is_action_just_released("jump") and velocity.y <= -min_jump_height:
			velocity.y = -min_jump_height
		
		handle_body_in_air()
	
	process(input)
	
	if input.x == 0 and velocity.x == 0:
		animation_player.play("Idle")
	else:
		animation_player.play("Run")

