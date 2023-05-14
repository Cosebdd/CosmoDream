extends Node

func _on_CutSceneDriver_cut_scene_over():#HACK: the scene won't start if preloaded because of cyclic reference
	var game_start = load("res://game-start/GameStart.tscn")
	get_tree().change_scene_to(game_start)
