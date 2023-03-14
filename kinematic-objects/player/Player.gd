extends KinematicObject

onready var animation_player := $AnimationPlayer
onready var body := $Body
onready var remote_transform := $RemoteTransform2D
onready var ability_system := $Body/AbilitySystem

enum {
	idle,
	run,
	jump,
}

var _state = idle

func _ready() -> void:
	ability_system.set_direction(Vector2.RIGHT)


func _physics_process(_delta) -> void:
	apply_gravity()
	
	var input = Vector2.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	
	if input.x < 0:
		body.scale.x = -1
		ability_system.set_direction(Vector2.LEFT)
	if input.x > 0:
		body.scale.x = 1
		ability_system.set_direction(Vector2.RIGHT)
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			jump()
	else:
		if Input.is_action_just_released("jump") and velocity.y <= -min_jump_height:
			velocity.y = -min_jump_height
		
		handle_body_in_air()
	
	process(input)
	
	# handle only animations state
	match _state:
		idle: _idle()
		run: _run()
		jump: _jump()


func _idle() -> void:
	animation_player.play("Idle")
	
	if not is_on_floor():
		_state = jump
		return
	
	if velocity.x != 0:
		_state = run


func _run() -> void:
	animation_player.play("Run")
	
	if not is_on_floor():
		_state = jump
		return

	if velocity.x == 0:
		_state = idle


func _jump() -> void:
	if animation_player.current_animation != "Jump" and animation_player.current_animation != '':
		animation_player.play("Jump")
	
	if is_on_floor():
		_state = idle


func connect_camera(camera: Camera2D) -> void:
	remote_transform.remote_path = camera.get_path()
