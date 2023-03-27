extends Node2D

export(PackedScene) var nextScene

onready var player := $Player
onready var camera := $Camera2D
onready var transitionScene: = preload("res://UI/LevelTransition.tscn")

func _ready() -> void:
	player.connect_camera(camera)
	add_child(transitionScene.instance())

func _on_NextLevelArea_body_entered(body):
	if body.get_name() == "Player":
		var final_transition = transitionScene.instance()
		final_transition.is_next_scene_transition = true
		final_transition.next_scene = nextScene
		add_child(final_transition)
	
