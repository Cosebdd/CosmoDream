extends Control

onready var bar_path = "CanvasLayer/Ability%s/VBoxContainer/HP"
onready var panel_path = "CanvasLayer/Ability%s"
onready var bars_ability = []
onready var panels_ability = []
var ability_cell_number = 4
	


func _ready():
	# Test until there is a state of the player implemented
	var max_health = get_node("../Enemy").max_health

	
	for i in range(1, ability_cell_number + 1):
		bars_ability.append(get_node(bar_path%i))
		panels_ability.append(get_node(panel_path%i))
		
	bars_ability[0].max_value = max_health
	
	
func _process(_delta):
	pass

func get_list_of_abilities() -> Array:
	# Read list of current abilities from state
	return []
	
func _on_cell_health_changed(ability, health_value):
	bars_ability[ability].value = health_value
	if health_value <= 0:
		panels_ability[ability].visible = false
	
func _on_cell_weapon_changed(ability, weapon_value):
	pass

		
