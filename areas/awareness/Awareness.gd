extends Area2D
class_name Awareness

signal player_inside(player)
signal player_outside

func _on_Awareness_body_entered(body: Player):
	if not (body is Player): return
	emit_signal("player_inside", body)


func _on_Awareness_body_exited(body: Player):
	if not (body is Player): return
	emit_signal("player_outside")
