extends Node2D

export(PackedScene) var nextScene

onready var player := $Player
onready var camera := $Camera2D

func _ready() -> void:
	player.connect_camera(camera)


func _on_NextLevelArea_body_entered(body):
	if body.get_name() == "Player":
		get_tree().change_scene(nextScene.resource_path)
