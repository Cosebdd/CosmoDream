extends KinematicObject
class_name Player

signal player_jumped
signal on_player_death

onready var animation_player := $AnimationPlayer
onready var animation_tree := $AnimationTree
onready var body := $Body
onready var remote_transform := $RemoteTransform2D
onready var ability_system := $AbilitySystem
onready var collision := $CollisionShape2D
onready var invincivility_timer := $InvincibilityTimer
onready var sound_effects := $Sfx
onready var direction := Vector2.RIGHT
onready var Heads := [$Body/Polygons/Torso/Heads/Cell1, $Body/Polygons/Torso/Heads/Cell2, $Body/Polygons/Torso/Heads/Cell3, $Body/Polygons/Torso/Heads/Cell4]
var size_rect: Rect2

export(float) var invincibility_time_after_damage = 0.5

enum movement { idle, run }

enum in_air_state { ground, air }

enum {
	idle,
	run,
	jump,
}

var _state = idle


func _ready() -> void:
	size_rect = _get_size_rect()
	ability_system.set_owner(self)
	sound_effects.set_owner(self)
	invincivility_timer.wait_time = invincibility_time_after_damage
	max_health = Config.get_player_max_health()
	health = WorldState.get_player_health()
	
	


func _physics_process(delta) -> void:
	apply_gravity()
	
	var input = Vector2.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	
	if input.x < 0:
		body.scale.x = -1
		direction = Vector2.LEFT
	if input.x > 0:
		body.scale.x = 1
		direction = Vector2.RIGHT
	
	if Input.is_action_just_pressed("base_attack"):
		animation_tree.set("parameters/Melee/active", true)
	
	if is_on_floor():
		handle_body_in_air()
	elif Input.is_action_just_released("jump") and velocity.y <= -min_jump_height:
		velocity.y = -min_jump_height
	
	if Input.is_action_just_pressed("jump") and jumps_count > 0:
		emit_signal("player_jumped")
		jump()
	
	process(input, delta)
	
	# handle only animations state
	match _state:
		idle: _idle()
		run: _run()
		jump: _jump()


func _idle() -> void:
	animation_tree.set("parameters/movement/current", movement.idle)
	
	if not is_on_floor():
		_state = jump
		return
	
	if velocity.x != 0:
		_state = run


func _run() -> void:
	animation_tree.set("parameters/movement/current", movement.run)
	
	if not is_on_floor():
		_state = jump
		return

	if velocity.x == 0:
		_state = idle


func _jump() -> void:
	if animation_player.current_animation != "Jump" and animation_player.current_animation != '':
		animation_tree.set("parameters/in_air_state/current", in_air_state.air)
	
	if is_on_floor():
		_state = idle
		animation_tree.set("parameters/in_air_state/current", in_air_state.ground)


func connect_camera(camera: Camera2D) -> void:
	remote_transform.remote_path = camera.get_path()


func _get_size_rect() -> Rect2:
	var collision_extents = collision.shape.extents
	var start_pos = Vector2(
		collision.position.x - collision_extents.x,
		collision.position.y - collision_extents.y
	)
	return Rect2(start_pos, collision_extents * 2)


func _on_Shot_Started() -> void:
	animation_tree.set("parameters/Shot/active", true)


func _on_Hurtbox_hit_taken(damage: int, object):
	if not invincivility_timer.is_stopped(): return
	
	var classn = object.get_class()
	
	var bullet := object as Bullet
	if bullet && bullet.is_safe_for_player:
		return
	
	if not is_invincible:
		get_damaged(damage, object)
		Events.emit_signal("user_gets_damage", damage)
		invincivility_timer.start()


func die() -> void:
	emit_signal("on_player_death")
