extends Node2D

var _owner
onready var shoot_sound := $ShotgunShot
onready var jump := $Jump
onready var sword := $Sword
onready var hurt := $Hurt
onready var dash := $Dash

func _ready() -> void:
	Events.connect("user_gets_damage", self, "_on_player_gets_damage")
	Events.connect("player_dashes", self, "_on_player_dashes")

func set_owner(owner_body) -> void:
	_owner = owner_body

func play_shot_sound() -> void:
	var pan_offset = 70		
	var sound_position = Vector2(0,  0)

	if _owner.direction.x > 0:
		sound_position.x += pan_offset
	else:
		sound_position.x -= pan_offset
	
	shoot_sound.position = sound_position
	shoot_sound.play()

func _on_player_jumped():
	jump.play()

func play_sword_sound():
	sword.play()

func _on_player_gets_damage(damage):
	hurt.play()
	
func _on_player_dashes():
	dash.play()
