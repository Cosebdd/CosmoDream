extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Fade in")
	yield(get_tree().create_timer(13), "timeout")
	$AnimationPlayer.play("Fade out")
