extends Node2D

const ABILITY_ACTION_PREFFIX := "use_ability_"

export(int) var ability_cell_number = 4

var ability_list = []


func _physics_process(_delta) -> void:
	for i in range(1, ability_cell_number + 1):
		var action_name = ABILITY_ACTION_PREFFIX + str(i)
		
		if Input.is_action_pressed(action_name):
			print("I'm using %s" % action_name)
			pass # apply ability in particular cell
		
		if Input.is_action_just_released(action_name):
			print("I stopped using %s" % action_name)
			pass # stop applying ability in particular cell


func set_ability(ability: Resource, cell: int) -> void:
	ability_list[cell] = ability


func remove_ability(cell: int) -> void:
	ability_list[cell] = null
