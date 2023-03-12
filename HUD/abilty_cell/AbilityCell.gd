extends MarginContainer


onready var bar = $"./VBoxContainer/HPBar"

func _ready():
	var max_health = get_node("../Enemy").max_health
	bar.max_value = max_health
	




func _on_Enemy_health_changed(health_value):
	bar.value = health_value
