extends KinematicBody2D
class_name Bullet

export(int) var speed = 200
onready var _ttl := $TTL
onready var sprite := $Sprite

var _direction = Vector2.ZERO
var _delay = 0.0

func _ready():
	sprite.visible = false


func _physics_process(delta: float) -> void:
	if _delay > 0:
		_delay -= delta
		return
	
	if _ttl.is_stopped():
		sprite.visible = true
		_ttl.start()
	
	var _velocity = move_and_slide(_direction * speed)
	if _velocity.distance_to(Vector2.ZERO) < speed:
		queue_free()


func _on_Hitbox_hit_target() -> void:
	queue_free()


func _on_TTL_timeout():
	queue_free()


func set_direction(direction: Vector2) -> void:
	_direction = direction.normalized()
	rotation = Vector2.RIGHT.angle_to(_direction)
	
	
func set_spawn_delay(delay: float) -> void:
	_delay = delay
