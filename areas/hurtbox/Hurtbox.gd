extends Area2D
class_name Hurtbox

signal hit_taken(damage)


func _on_Hurtbox_area_entered(area: Hitbox):
	if not (area is Hitbox): return
	
	emit_signal("hit_taken", area.hit_damage)
