extends Node2D
class_name AbilitySystem

const _ABILITY_ACTION_PREFFIX := "use_ability_"

export(int) var ability_cell_number = 4

var ability_list = []
var _owner setget set_owner

var Shooting = preload("res://abilities/list/shooting/Shooting.tscn")
var Shield = preload("res://abilities/list/shield/Shield.tscn")
var DubleJump = preload("res://abilities/list/duble-jump/DubleJump.tscn")


func _ready() -> void:
	for _i in range(ability_cell_number):
		ability_list.append(null)
	
	put_ability(Shooting, 0)
	put_ability(Shield, 1)
	put_ability(DubleJump, 2)


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


func put_ability(ability, cell: int) -> void:
	var old_ability: Ability = ability_list[cell]
	if old_ability is Ability:
		old_ability.queue_free()
	
	var ability_instance = ability.instance()
	if _owner: ability_instance.set_owner(_owner)
	ability_list[cell] = ability_instance
	add_child(ability_instance)


func set_abilities(abilities) -> void:
	for i in range(abilities.size()):
		put_ability(abilities[i], i)


func remove_ability(cell: int) -> void:
	var ability_to_remove: Ability = ability_list[cell]
	ability_to_remove.queue_free()
	ability_list[cell] = null


func clear_abilityes() -> void:
	for i in range(ability_list.size()):
		remove_ability(i)


func set_owner(owner_body) -> void:
	_owner = owner_body
	for ability in ability_list:
		if ability: ability.set_owner(_owner)
