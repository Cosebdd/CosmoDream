extends Area2D
class_name Hitbox

signal hit_target

export(int) var hit_damage = 1


func _on_Hitbox_area_entered(_area):
	emit_signal("hit_target")


func _on_Hitbox_body_entered(body):
	if owner == body: return
	emit_signal("hit_target")
