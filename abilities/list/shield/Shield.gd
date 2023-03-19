extends Ability
class_name ShieldAbility


onready var sprite := $Sprite
onready var collision := $CollisionShape2D


func _process(_delta) -> void:
	if not _owner: return
	
	position = Vector2(
		_owner.size_rect.position.x + _owner.size_rect.size.x / 2,
		_owner.size_rect.position.y + _owner.size_rect.size.y / 2
	)
	sprite.visible = active
	collision.disabled = !active


func _fire_implementation() -> void:
	pass
