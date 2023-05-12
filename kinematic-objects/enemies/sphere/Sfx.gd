extends Node2D

onready var attack_sound := $AttackSound
onready var damage_sound := $DamageSound

func play_attack_sound() -> void:
	attack_sound.play()

func _on_SphereRobot_on_damage_taken():
	damage_sound.play()
