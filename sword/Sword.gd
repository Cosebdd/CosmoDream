extends Node2D
class_name Sword

onready var animation_player := $AnimationPlayer


func _process(_delta: float) -> void:
	if not Input.is_action_just_pressed("base_attack"): return
	animation_player.play("hit")

