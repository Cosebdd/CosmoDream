extends Ability
class_name ShootingAbility

var Bullet = preload("res://abilities/list/shooting/bullet/Bullet.tscn")


func _execute():
	._execute()
	
	var offset_x = _owner_rect.size.x * _direction.x
	var owner_center_position = Vector2(
		_owner_rect.position.x + _owner_rect.size.x / 2 + offset_x,
		_owner_rect.position.y + _owner_rect.size.y / 2
	)
	
	var bullet = Bullet.instance()
	bullet.set_direction(_direction)
	get_tree().root.get_child(0).add_child(bullet)
	bullet.global_position = global_position + owner_center_position
