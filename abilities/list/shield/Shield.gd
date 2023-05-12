extends Ability
class_name ShieldAbility


onready var sprite := $Sprite
onready var collision := $CollisionShape2D
onready var shield_sound := $ShieldSound


func _process(_delta) -> void:
	if not _owner or is_destroyed(): return

	position = Vector2(
		_owner.size_rect.position.x + _owner.size_rect.size.x / 2,
		_owner.size_rect.position.y + _owner.size_rect.size.y / 2
	)
	shield_sound.playing = active
	sprite.visible = active
	collision.disabled = !active
	_owner.set_invincibility(active)


func _fire_implementation() -> void:
	pass
