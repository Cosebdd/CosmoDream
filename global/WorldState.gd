extends Node

var ability_cell_number = Config.get_ability_cell_number()
var ability_max_health = Config.get_ability_max_health()
var player_max_health = Config.get_player_max_health()
var ability_state = {
	"ShootingAbility": ability_max_health, 
	"Shield": ability_max_health, 
	"DubleJump": ability_max_health, 
	"StrafeAbility": ability_max_health
}

var player_state = {
	"health": player_max_health
}


func _ready():
	Events.connect("ability_gets_damage", self,  "_on_ability_gets_damage")
	Events.connect("user_gets_damage", self, "_on_user_gets_damage")


func _on_ability_gets_damage(ability, ability_index, damage):
	var ability_name = ability.get_name()
	ability_state[ability_name] = clamp(ability_state[ability_name] - damage, 0, ability.max_health)


func _on_user_gets_damage(damage):
	player_state["health"] = clamp(player_state["health"] - damage, 0, player_max_health)


func get_ability_state():
	return ability_state


func get_player_health():
	return player_state["health"]

func reset_abilities():
	ability_cell_number = Config.get_ability_cell_number()
	ability_max_health = Config.get_ability_max_health()
	player_max_health = Config.get_player_max_health()
	ability_state = {
		"ShootingAbility": ability_max_health, 
		"Shield": ability_max_health, 
		"DubleJump": ability_max_health, 
		"StrafeAbility": ability_max_health
	}
	player_state = {
		"health": player_max_health
	}
