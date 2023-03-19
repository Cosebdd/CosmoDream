extends Node2D
class_name LaserBeem

export(int) var max_length = 2000

onready var beem := $Beem
onready var ray := $RayCast2D
onready var end := $End
onready var hitbox := $Hitbox/CollisionShape2D

var _collision: RectangleShape2D
var _active = false

func _physics_process(_delta):
	if _active:
		hitbox.disabled = false
		visible = true
		var max_point = Vector2.RIGHT * max_length
		ray.cast_to = max_point
		
		if ray.is_colliding():
			max_point = ray.get_collision_point()
		
		end.global_position = max_point
		beem.region_rect.end.x = max_point.length()
		hitbox.shape.extents.x = max_point.length()
	else:
		hitbox.disabled = true
		visible = false


func set_active(active: bool) -> void:
	_active = active
