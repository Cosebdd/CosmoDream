extends Node

export(int) var player_max_health = 3
export(int) var ability_cell_number = 4
var player_health = player_max_health
var ability_list = []

var Shooting = preload("res://abilities/list/shooting/Shooting.tscn")
var Shield = preload("res://abilities/list/shield/Shield.tscn")
var DubleJump = preload("res://abilities/list/duble-jump/DubleJump.tscn")
var Strafe = preload("res://abilities/list/strafe/Strafe.tscn")



func _ready():
	Events.connect("set_abilities", self, "_on_set_abilities")
	randomize()
	for i in range(ability_cell_number):
		ability_list.append(null)
	
	put_ability(Shooting, 0)
	put_ability(Shield, 1)
	put_ability(DubleJump, 2)
	put_ability(Strafe, 3)
	
func put_ability(ability, cell: int) -> void:
	var old_ability: Ability = ability_list[cell]
	if old_ability is Ability:
		old_ability.queue_free()
	
	var ability_instance = ability.instance()
	ability_list[cell] = ability_instance
	
func get_ability_list():
	return ability_list

func set_player_health(value):
	player_health = value

func get_player_health():
	return player_health

func set_max_health(value):
	player_max_health = value

func get_max_health():
	return player_max_health

func _on_set_abilities(ability_list_new):
	ability_list = ability_list_new
	
func reset():
	player_health = player_max_health
		

