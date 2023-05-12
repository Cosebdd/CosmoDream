extends Node2D

export(PackedScene) var nextScene
export(AudioStreamMP3) var music

onready var player := $Player
onready var camera := $Camera2D
onready var transitionScene: = preload("res://UI/LevelTransition.tscn")
onready var deathTransitionScene: = load("res://UI/DeathTransition.tscn")
onready var music_player := AudioStreamPlayer.new()

func _ready() -> void:
	if music != null:
		add_child(music_player)
		music_player.stream = music
		music_player.playing = true
	player.connect_camera(camera)
	add_child(transitionScene.instance())
	player.connect("on_player_death", self, "_on_player_death")

func _on_NextLevelArea_body_entered(body):
	if body.get_name() == "Player":
		var final_transition = transitionScene.instance()
		final_transition.is_next_scene_transition = true
		final_transition.next_scene = nextScene
		add_child(final_transition)

func _on_player_death():
	var death_transition = deathTransitionScene.instance()
	add_child(death_transition)
