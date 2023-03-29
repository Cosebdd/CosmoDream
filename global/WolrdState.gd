extends Node

export(int) var player_max_health = 3
export(int) var ability_cell_number = 4
var player_health = player_max_health
var ability_state = {"ShootingAbility": 1, "Shield": 1, "DubleJump": 1, "StrafeAbility": 1}



func _ready():
	Events.connect("ability_gets_damage", self,  "_on_ability_gets_damage")

func _on_ability_gets_damage(ability, ability_index, damage):
	var ability_name = ability.get_name()
	ability_state[ability_name] = clamp(ability_state[ability_name] - damage, 0, ability.max_health)
	
	
func get_ability_state():
	return ability_state
	

func set_player_health(value):
	player_health = value

func get_player_health():
	return player_health

func set_max_health(value):
	player_max_health = value

func get_max_health():
	return player_max_health
	
func reset():
	player_health = player_max_health
		

