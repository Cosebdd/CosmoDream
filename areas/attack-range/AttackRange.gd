extends Area2D
class_name AttackRange

signal enemy_inside_range(body)
signal enemy_outside_range

func _on_AttackRange_body_entered(body: Player):
	if body is Player:
		emit_signal("enemy_inside_range", body)



func _on_AttackRange_body_exited(body):
	if body is Player:
		emit_signal("enemy_outside_range")
