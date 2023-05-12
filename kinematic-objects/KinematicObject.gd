extends KinematicBody2D
class_name KinematicObject

signal on_damage_taken

export(int) var max_speed = 100
export(int) var acceleration = 1500
export(int) var friction = 1500
export(int) var gravity = 10
export(int) var max_gravity = 200
export(int) var gravity_enhancement = 4
export(int) var max_health = 3
export(int) var jump_height = 200
export(int) var min_jump_height = 30
export(int) var jump_acceleration_point = 10
export(int) var max_jumps = 1
export(bool) var is_invincible = false
export(PackedScene) var instantiate_on_death;

var velocity := Vector2.ZERO
onready var jumps_count = max_jumps
onready var hit_points = max_health
onready var health = max_health


func apply_gravity() -> void:
	velocity.y = min(velocity.y + gravity, max_gravity)


func apply_friction(delta: float) -> void:
	velocity.x = move_toward(velocity.x, 0, friction * delta)


func apply_acceleretion(direction: int, delta: float) -> void:
	velocity.x = move_toward(velocity.x, max_speed * direction, acceleration * delta)


func handle_body_in_air() -> void:
	if velocity.y > jump_acceleration_point:
		velocity.y += gravity_enhancement


func jump() -> void:
	velocity.y = -jump_height
	jumps_count = clamp(jumps_count - 1, 0, max_jumps)


func handle_damage(damage: int) -> void:
	hit_points = clamp(hit_points - damage, 0, max_health)


func die() -> void:
	if instantiate_on_death != null:
		var instance = instantiate_on_death.instance()
		instantiate_on_death = null
		instance.position = position
		get_parent().add_child(instance)
	queue_free()


func get_damaged(damage: int, damage_deeler) -> void:
	if is_invincible: return
	
	emit_signal("on_damage_taken")
	
	_hit_transition(damage_deeler)
	health = clamp(health - damage, 0, max_health)
	
	if health <= 0:
		die()


func set_invincibility(_invincibility: bool) -> void:
	is_invincible = _invincibility


func _hit_transition(damage_deeler) -> void:
	var position_punch = -10 * Vector2(damage_deeler.global_position.x - global_position.x, 0).normalized()
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, 'position', Vector2(position.x + position_punch.x, position.y), 0.1)
	tween.parallel()
	tween.tween_property(self, 'modulate', Color('70ff0000'), 0.1)
	tween.tween_property(self, 'modulate', Color(1,1,1,1), 0.1)


func process(input: Vector2, delta: float) -> void:
	if input.x == 0:
		apply_friction(delta)
	else:
		apply_acceleretion(input.x, delta)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor():
		jumps_count = max_jumps
	elif jumps_count == max_jumps:
		jumps_count = clamp(jumps_count - 1, 0, max_jumps)
