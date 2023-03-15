extends Ability
class_name StrafeAbility

export(int) var strafe_speed = 600


func _execute() -> void:
	._execute()
	_owner.velocity.x = strafe_speed * _owner.direction.x
