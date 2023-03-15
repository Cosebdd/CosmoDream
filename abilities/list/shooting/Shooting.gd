extends Ability
class_name ShootingAbility

export(int) var spread_angle = 10
export(int) var fragment_number = 6
export(float) var delay_range = 0.2

var Bullet = preload("res://abilities/list/shooting/bullet/Bullet.tscn")


func _execute():
	._execute()
	_shot()


func _shot() -> void:
	var offset_x = _owner.size_rect.size.x * _owner.direction.x
	var owner_center_position = Vector2(
		_owner.size_rect.position.x + _owner.size_rect.size.x / 2 + offset_x,
		_owner.size_rect.position.y + _owner.size_rect.size.y / 2
	)
	
	var bullet = Bullet.instance()
	bullet.set_direction(_owner.direction)
	get_tree().root.get_child(0).add_child(bullet)
	bullet.global_position = global_position + owner_center_position
