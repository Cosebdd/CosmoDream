extends KinematicBody2D
class_name KinematicObject

export(int) var max_speed = 100
export(int) var acceleration = 15
export(int) var friction = 15
export(int) var gravity = 10
export(int) var max_gravity = 200
export(int) var gravity_enhancement = 4
export(int) var max_health = 3
export(int) var jump_height = 200
export(int) var min_jump_height = 30
export(int) var jump_acceleration_point = 10
export(int) var max_jumps = 1

var velocity := Vector2.ZERO
onready var jumps_count = max_jumps
onready var hit_points = max_health


func apply_gravity() -> void:
	velocity.y = min(velocity.y + gravity, max_gravity)


func apply_friction() -> void:
	velocity.x = move_toward(velocity.x, 0, friction)


func apply_acceleretion(direction: int) -> void:
	velocity.x = move_toward(velocity.x, max_speed * direction, acceleration)


func handle_body_in_air() -> void:
	if velocity.y > jump_acceleration_point:
		velocity.y += gravity_enhancement


func jump() -> void:
	velocity.y = -jump_height
	jumps_count = clamp(jumps_count - 1, 0, max_jumps)


func handle_damage(damage: int) -> void:
	hit_points = clamp(hit_points - damage, 0, max_health)


func process(input: Vector2) -> void:
	if input.x == 0:
		apply_friction()
	else:
		apply_acceleretion(input.x)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor():
		jumps_count = max_jumps
	elif jumps_count == max_jumps:
		jumps_count = clamp(jumps_count - 1, 0, max_jumps)
