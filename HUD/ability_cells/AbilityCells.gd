extends Control


onready var bar = $"./CanvasLayer/PanelContainer/VBoxContainer/TextureProgress"
onready var panel = $"CanvasLayer/PanelContainer"

func _ready():
	var max_health = get_node("../Enemy").max_health
	bar.max_value = max_health
	




func _on_Enemy_health_changed(health_value):
	bar.value = health_value
	if health_value <= 0:
		panel.visible = false
		
