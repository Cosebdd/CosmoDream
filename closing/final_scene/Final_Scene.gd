extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$FadingAnimation.play("Fade in")
	yield(get_tree().create_timer(4), "timeout")
	$KillswitchOFF.visible = true
	yield(get_tree().create_timer(8), "timeout")
	$FadingAnimation.play("Fade out")
	yield(get_tree().create_timer(3), "timeout")
	get_tree().change_scene("res://opening/Opening1A/Opening1A.tscn")
