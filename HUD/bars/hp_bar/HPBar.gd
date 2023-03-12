extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var bar = $"./Margin/HBoxContainer/Bar"

# Called when the node enters the scene tree for the first time.
func _ready():
	var max_health = get_node("..").max_health
	bar.max_value = max_health
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Enemy_health_changed(health_value):
	bar.value = health_value
