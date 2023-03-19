extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Fade in")
	yield(get_tree().create_timer(15), "timeout")
	$AnimationPlayer.play("Fade out")
	yield(get_tree().create_timer(3), "timeout")
	get_tree().change_scene("res://opening/Opening2A/Opening2A.tscn")
