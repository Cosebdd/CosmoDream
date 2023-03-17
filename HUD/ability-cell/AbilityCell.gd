extends PanelContainer
class_name AbilityCell

onready var hp_box := $HBoxContainer/HP
onready var ep_box := $HBoxContainer/EP
onready var picture := $HBoxContainer/Pic

export(float) var box_animation_time = 0.3


func init(max_hp: float, max_ep: float):
	hp_box.max_value = max_hp
	ep_box.max_value = max_ep
	hp_box.value = max_hp
	ep_box.value = max_ep


func set_hp(hp: float) -> void:
	_tween_bar(hp_box, hp)


func set_ep(ep: float) -> void:
	_tween_bar(ep_box, ep)


func set_hp_diff(hp_diff: float) -> void:
	_tween_bar(hp_box, hp_box.value + hp_diff, true)


func set_ep_diff(ep_diff: float) -> void:
	_tween_bar(ep_box, ep_box.value + ep_diff, true)


func _tween_bar(object: TextureProgress, value: int, with_color_effect = false) -> void:
	var tween := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(object, "value", value, box_animation_time)
	object.modulate
	if with_color_effect:
		var color
		if value < object.value:
			color = Color('ff0000')
		else:
			color = Color('80ff6a')
		tween.parallel()
		tween.tween_property(object, "modulate", color, 0.15)
		tween.tween_property(object, "modulate", Color(1,1,1,1), 0.15)



