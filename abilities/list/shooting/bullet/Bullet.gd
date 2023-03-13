extends KinematicBody2D
class_name Bullet

export(int) var speed = 100
onready var _velocity: Vector2 = Vector2.UP.rotated(rotation) * speed
onready var _ttl := $TTL


func _ready():
	_ttl.start()


func _physics_process(_delta) -> void:
	_velocity = move_and_slide(_velocity)


func _on_Hitbox_hit_target() -> void:
	queue_free()


func _on_TTL_timeout():
	queue_free()
