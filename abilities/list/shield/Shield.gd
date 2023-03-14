extends Ability
class_name ShieldAbility


onready var sprite := $Sprite
onready var collision := $CollisionShape2D


func _process(_delta) -> void:
	position = Vector2(
		_owner_rect.position.x + _owner_rect.size.x / 2,
		_owner_rect.position.y + _owner_rect.size.y / 2
	)
	sprite.visible = active
	collision.disabled = !active
