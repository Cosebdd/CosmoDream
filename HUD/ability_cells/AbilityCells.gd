extends Control


onready var bar = $"./CanvasLayer/Ability1/VBoxContainer/HP"
onready var panel = $"CanvasLayer/Ability1"

func _ready():
	var max_health = get_node("../Enemy").max_health
	bar.max_value = max_health
	




func _on_Enemy_health_changed(health_value):
	bar.value = health_value
	if health_value <= 0:
		panel.visible = false
		
