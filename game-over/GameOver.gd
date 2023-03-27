extends Control


export(float) var wait_time = 5.0
export(PackedScene) var next_scene

onready var animation_player := $AnimationPlayer

func _ready() -> void:
	animation_player.play("fadein")
	yield(get_tree().create_timer(wait_time), "timeout")
	_go_next()


func _go_next() -> void:
	if not next_scene: return
	
	animation_player.play("fadeout")
	yield(animation_player, "animation_finished")
	get_tree().change_scene_to(next_scene)
