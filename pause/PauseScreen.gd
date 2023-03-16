extends Control


onready var canvas := $CanvasLayer

func _ready():
	canvas.visible = false


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
		canvas.visible = get_tree().paused
