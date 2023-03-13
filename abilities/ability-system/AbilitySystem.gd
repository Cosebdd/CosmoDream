extends Node2D
class_name AbilitySystem

const _ABILITY_ACTION_PREFFIX := "use_ability_"

export(int) var ability_cell_number = 4
var ability_list = []


func _ready() -> void:
	for i in range(0, ability_cell_number + 1):
		ability_list.append(null)


func _physics_process(_delta) -> void:
	for i in range(1, ability_cell_number + 1):
		var ability = ability_list[i - 1]
		if not ability: return
		
		ability = ability as Ability
		
		var action_name = _ABILITY_ACTION_PREFFIX + str(i)
		
		if Input.is_action_pressed(action_name):
			ability.activate()
		
		if Input.is_action_just_released(action_name):
			ability.deactivate()


func set_abilities(abilities) -> void:
	ability_list = abilities
	for ability in abilities:
		add_child(ability.instance())


func put_ability(ability: Ability, cell: int) -> void:
	ability_list[cell] = ability.instance()
	add_child(ability)


func clear_abilityes() -> void:
	for ability in ability_list:
		ability.queue_free()
	ability_list = []


func remove_ability(cell: int) -> void:
	var ability_to_remove: Ability = ability_list[cell]
	ability_to_remove.queue_free()
	ability_list[cell] = null
	
