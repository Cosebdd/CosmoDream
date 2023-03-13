extends KinematicObject

signal health_changed


func _physics_process(_delta) -> void:
	apply_gravity()
	process(Vector2.ZERO)

func _on_Hurtbox_hit_taken(damage: int) -> void:
	hit_points = clamp(hit_points - damage, 0, max_health)
	
	emit_signal("health_changed", hit_points)
	
	if hit_points == 0:
		queue_free()
