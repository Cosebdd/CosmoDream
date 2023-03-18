extends PanelContainer
class_name AbilityCell

onready var hp_box := $HBoxContainer/HP
onready var ep_box := $HBoxContainer/EP
onready var picture := $HBoxContainer/Pic

export(float) var box_animation_time = 0.3

var _ability: Ability

func init(ability):
	_ability = ability as Ability
	hp_box.max_value = float(_ability.max_health)
	hp_box.value = float(_ability.max_health)
	
	var max_ep_value = float(_ability.charge_limit) if _ability.charge_limit else 0
	ep_box.max_value = max_ep_value
	ep_box.value = max_ep_value
	
	_ability.connect("charges_updated", self, "set_ep")


func _exit_tree():
	_ability.disconnect("charges_updated", self, "set_ep")


func set_picture(pic: Texture) -> void:
	picture.texture = pic


func set_hp(hp: float) -> void:
	_tween_bar(hp_box, hp)


func set_ep(ep) -> void:
	_tween_bar(ep_box, float(ep))


func set_hp_diff(hp_diff: float) -> void:
	_tween_bar(hp_box, hp_box.value + hp_diff, true)


func set_ep_diff(ep_diff: float) -> void:
	_tween_bar(ep_box, ep_box.value + ep_diff)


func _tween_bar(object: TextureProgress, value: float, with_color_effect = false, time = box_animation_time) -> void:
	var tween := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(object, "value", value, time)
	
	if with_color_effect:
		var color
		if value < object.value:
			color = Color('ff0000')
		else:
			color = Color('80ff6a')
		tween.parallel()
		tween.tween_property(object, "modulate", color, 0.15)
		tween.tween_property(object, "modulate", Color(1,1,1,1), 0.15)

