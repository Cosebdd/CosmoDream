extends Ability
class_name ShootingAbility

var Bullet = preload("res://abilities/list/shooting/bullet/Bullet.tscn")

func _execute():
	._execute()
	
	var bullet = Bullet.instance()
	bullet.rotation = Vector2.DOWN.angle()
	get_tree().root.get_child(0).add_child(bullet)
	bullet.global_position = global_position
