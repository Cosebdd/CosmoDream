extends Node


var player_config_data = {
	"max_health": 4
}

var ability_config_data = {
	"ability_cell_number": 4,
	"ability_max_health": 1
}


func get_player_max_health():
	return player_config_data["max_health"]


func get_ability_cell_number():
	return ability_config_data["ability_cell_number"]


func get_ability_max_health():
	return ability_config_data["ability_max_health"]
