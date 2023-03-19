extends Area2D
class_name Hurtbox

signal hit_taken(damage)


func _on_Hurtbox_area_entered(area: Hitbox):
	if owner == area.owner: return
	emit_signal("hit_taken", area.hit_damage)
