extends Area2D
class_name Hitbox

signal hit_target

export(int) var hit_damage = 1


func _on_Hitbox_area_entered(area):
	if owner == area.owner: return
	emit_signal("hit_target")
