extends KinematicBody2D
class_name Bullet

export(int) var speed = 300
onready var _ttl := $TTL

var _direction = Vector2.ZERO


func _ready():
	_ttl.start()


func _physics_process(_delta) -> void:
	var _velocity = move_and_slide(_direction * speed)
	if abs(_velocity.x) < speed:
		queue_free()


func _on_Hitbox_hit_target() -> void:
	queue_free()


func _on_TTL_timeout():
	queue_free()


func set_direction(direction: Vector2) -> void:
	_direction = direction.normalized()
	rotation = Vector2.UP.angle_to(_direction)
