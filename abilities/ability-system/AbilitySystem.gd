extends Node2D
class_name AbilitySystem

const _ABILITY_ACTION_PREFFIX := "use_ability_"

export(int) var ability_cell_number = 4

var ability_list = []
var _owner setget set_owner

var Shooting = preload("res://abilities/list/shooting/Shooting.tscn")
var Shield = preload("res://abilities/list/shield/Shield.tscn")
var DubleJump = preload("res://abilities/list/duble-jump/DubleJump.tscn")
var Strafe = preload("res://abilities/list/strafe/Strafe.tscn")
var ability_state = WolrdState.get_ability_state()

func _ready() -> void:
	randomize()
	Events.connect("user_gets_damage", self, "_on_Player_gets_damage")
	for _i in range(ability_cell_number):
		ability_list.append(null)
	
	put_ability(Shooting, 0)
	put_ability(Shield, 1)
	put_ability(DubleJump, 2)
	put_ability(Strafe, 3)


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
	var ability_name = ability_instance.get_name()
	ability_instance.update_health(ability_state[ability_name])
	ability_list[cell] = ability_instance
	add_child(ability_instance)
	_emit_abilities_changes()


func set_abilities(abilities) -> void:
	for i in range(abilities.size()):
		put_ability(abilities[i], i)
	
	_emit_abilities_changes()



func remove_ability(cell: int) -> void:
	var ability_to_remove: Ability = ability_list[cell]
	ability_to_remove.queue_free()
	ability_list[cell] = null
	
	_emit_abilities_changes()


func clear_abilityes() -> void:
	for i in range(ability_list.size()):
		remove_ability(i)
	
	_emit_abilities_changes()


func set_owner(owner_body) -> void:
	_owner = owner_body
	for ability in ability_list:
		if ability: ability.set_owner(_owner)


func _emit_abilities_changes() -> void:
	Events.emit_signal("set_abilities", ability_list)


func _on_Player_gets_damage(damage) -> void:
	var is_all_destroyed = true
	for ability in ability_list:
		if not ability.is_destroyed():
			is_all_destroyed = false
			break
	
	if is_all_destroyed: return
	
	var ability_index = randi() % ability_list.size()
	while ability_list[ability_index].is_destroyed():
		ability_index = randi() % ability_list.size()
	
	var a = ability_list[ability_index]
	a.get_damage(damage)
	Events.emit_signal("ability_gets_damage", a, ability_index, damage)
