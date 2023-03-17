extends Control

onready var bar_path = "CanvasLayer/Ability%s/VBoxContainer/HP"
onready var panel_path = "CanvasLayer/Ability%s"
onready var bars_ability = []
onready var panels_ability = []
var ability_cell_number = 4
onready var AbilityCell = preload("res://HUD/ability-cell/AbilityCell.tscn")
onready var container = $CanvasLayer/HBoxContainer
var abilities = []

func _ready():
	var cell = AbilityCell.instance()
	container.add_child(cell)
	cell.init(100.0, 7.0)
	abilities.append(cell)


func _process(delta):
	if Input.is_action_just_pressed("test-injury"):
		abilities[0].set_hp_diff(-10.0)
	
	if Input.is_action_just_pressed("test-heal"):
		abilities[0].set_hp_diff(10.0)


func get_list_of_abilities() -> Array:
	# Read list of current abilities from state
	return []

func _on_cell_health_changed(ability, health_value):
	bars_ability[ability].value = health_value
	if health_value <= 0:
		panels_ability[ability].visible = false

func _on_cell_weapon_changed(ability, weapon_value):
	pass
