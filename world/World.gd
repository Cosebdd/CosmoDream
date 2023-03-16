extends Node2D

onready var player := $Player
onready var camera := $Camera2D

func _ready() -> void:
	player.connect_camera(camera)
