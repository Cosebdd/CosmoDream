extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$FadingAnimation.play("Fade in")
	yield(get_tree().create_timer(4), "timeout")
	$KillswitchOFF.visible = true
	yield(get_tree().create_timer(8), "timeout")
	$FadingAnimation.play("Fade out")
