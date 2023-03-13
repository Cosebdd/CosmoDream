extends KinematicObject

onready var animation_player := $AnimationPlayer
onready var body := $Body

func _physics_process(_delta):
	apply_gravity()
	
	var input = Vector2.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	
	if input.x < 0: body.scale.x = -1
	if input.x > 0: body.scale.x = 1
	
	var is_on_floor = is_on_floor();
	if is_on_floor:
		if Input.is_action_just_pressed("jump"):
			animation_player.play("Jump")
			jump()
			is_on_floor = false;
	else:
		if Input.is_action_just_released("jump") and velocity.y <= -min_jump_height:
			velocity.y = -min_jump_height
		
		handle_body_in_air()
	
	process(input)
	
	if !is_on_floor:
		return
	
	if input.x == 0 and velocity.x == 0:
		animation_player.play("Idle")
	else:
		animation_player.play("Run")
