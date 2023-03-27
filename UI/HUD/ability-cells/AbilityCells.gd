extends Control

onready var AbilityCell = preload("res://UI/HUD/ability-cell/AbilityCell.tscn")
onready var container = $CanvasLayer/HBoxContainer
var _abilities = []


func _ready():
	Events.connect("set_abilities", self, "_on_abilities_change")
	Events.connect("ability_gets_damage", self, "_on_ability_gets_damage")


func _clear_abilities() -> void:
	for a in _abilities:
		container.remove_child(a)


func _process_ability(ability) -> void:
	var _ability = ability as Ability
	var cell = AbilityCell.instance()
	container.add_child(cell)
	cell.init(_ability)
	_abilities.append(cell)


func _on_abilities_change(abilities: Array) -> void:
	_clear_abilities()
	_abilities = []
	for a in abilities:
		if not a: continue
		_process_ability(a)


func _on_ability_gets_damage(_ability, index, damage) -> void:
	var ability_cell = _abilities[index] as AbilityCell
	ability_cell.set_hp_diff(-damage)
