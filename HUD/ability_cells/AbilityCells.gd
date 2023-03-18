extends Control

onready var AbilityCell = preload("res://HUD/ability-cell/AbilityCell.tscn")
onready var container = $CanvasLayer/HBoxContainer
var _abilities = []


func _ready():
	Events.connect("set_abilities", self, "_on_abilities_change")


func _process(delta):
	if Input.is_action_just_pressed("test-injury"):
		_abilities[0].set_hp_diff(-10.0)
	
	if Input.is_action_just_pressed("test-heal"):
		_abilities[0].set_hp_diff(10.0)


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
