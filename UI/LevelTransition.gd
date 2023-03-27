extends Control

export var is_next_scene_transition: bool = false
export var next_scene: PackedScene

onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_next_scene_transition:
		animation_player.play("Finish")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Finish" and next_scene != null:
		get_tree().change_scene_to(next_scene)
