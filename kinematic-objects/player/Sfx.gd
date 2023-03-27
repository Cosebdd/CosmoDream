extends Node2D

var _owner
onready var shoot_sound := $ShotgunShot
onready var reload_sound := $ShotgunReload

func set_owner(owner_body) -> void:
	_owner = owner_body

func play_shot_sound() -> void:
	reload_sound.stop()	
	var pan_offset = 70		
	var sound_position = Vector2(0,  0)

	if _owner.direction.x > 0:
		sound_position.x += pan_offset
	else:
		sound_position.x -= pan_offset
	
	shoot_sound.position = sound_position
	shoot_sound.play()
	

func _on_ShotgunShot_finished():
	reload_sound.play()
