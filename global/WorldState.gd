extends Node


onready var ability_cell_number = Config.get_ability_cell_number()
onready var ability_max_health = Config.get_ability_max_health()
onready var ability_state = {
					"ShootingAbility": ability_max_health, 
					"Shield":          ability_max_health, 
					"DubleJump":       ability_max_health, 
					"StrafeAbility":   ability_max_health
					}



func _ready():
	Events.connect("ability_gets_damage", self,  "_on_ability_gets_damage")

func _on_ability_gets_damage(ability, ability_index, damage):
	var ability_name = ability.get_name()
	ability_state[ability_name] = clamp(ability_state[ability_name] - damage, 0, ability.max_health)
	
	
func get_ability_state():
	return ability_state

		

