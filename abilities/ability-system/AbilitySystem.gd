extends Node2D

const ABILITY_ACTION_PREFFIX := "use_abiliity_"

export(int) var ability_cell_number = 4

var ability_list = []


func _physics_process(_delta) -> void:
	for i in range(0, ability_cell_number + 1):
		var action_name = ABILITY_ACTION_PREFFIX + str(i)
		
		if Input.is_action_just_pressed(action_name):
			pass # apply ability in particular cell
		
		if Input.is_action_just_released(action_name):
			pass # stop applying ability in particular cell

