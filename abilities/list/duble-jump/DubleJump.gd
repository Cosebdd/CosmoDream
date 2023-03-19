extends Ability
class_name DubbleJump

export(int) var max_jumps = 2

var old_jumps_numner: int


func set_owner(owner_body) -> void:
	_owner = owner_body
	old_jumps_numner = _owner.max_jumps
	_owner.max_jumps = max_jumps


func _exit_tree() -> void:
	_owner.max_jumps = old_jumps_numner


func _fire_implementation() -> void:
	pass
