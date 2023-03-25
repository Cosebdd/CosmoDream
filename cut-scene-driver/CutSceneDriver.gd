extends Control
class_name CutSceneDriver

export(int) var textbox_margin = 4
export(Array, Resource) var scene_sequence
export(PackedScene) var after_finish_scene

onready var background := $Backgound
onready var overlay := $Camera2D/CanvasLayer/Overlay
onready var animation_player := $AnimationPlayer
onready var text_container := $Camera2D/CanvasLayer/TextContainer
onready var text := $Camera2D/CanvasLayer/TextContainer/SceneText
onready var camera := $Camera2D

var _current_scene


func _ready() -> void:
	_switch_scene()


func _input(event) -> void:
	if event.is_action_pressed("skip-cutscene") and animation_player.current_animation != "finish":
		if animation_player.is_playing():
			_finish_transition()
			return
		
		_finish_cut_scene()


func _run_scene(scene_to_play) -> void:
	_prepare_scene(scene_to_play)
	_start_backgound_transition(scene_to_play)
	animation_player.play("start")


func _prepare_scene(scene) -> void:
	var _scene = scene as CutSceneData
	background.texture = _scene.scene_image
	
	if _scene.camera_initial_position:
		camera.offset = _scene.camera_initial_position
	
	if _scene.image_scale:
		background.rect_scale = _scene.image_scale
	
	text_container.margin_top = -_scene.textbox_height - textbox_margin
	text_container.margin_bottom = -textbox_margin
	text_container.margin_left = textbox_margin
	text_container.margin_right = -textbox_margin
	
	text.percent_visible = 0
	text.text = scene.text


func _finish_cut_scene() -> void:
	animation_player.play("finish")


func _switch_scene() -> void:
	if scene_sequence.size() == 0:
		if after_finish_scene:
			get_tree().change_scene_to(after_finish_scene)
		return
	
	_current_scene = scene_sequence.pop_front()
	_run_scene(_current_scene)


func _start_backgound_transition(scene) -> void:
	var _scene = scene as CutSceneData
	if not _scene.camera_finish_position: return
	
	var animation = animation_player.get_animation("start")
	animation.track_set_key_value(2, 0, camera.offset)
	animation.track_set_key_value(2, 1, _scene.camera_finish_position)


func _finish_transition() -> void:
	animation_player.stop()
	text.percent_visible = 1.0
	overlay.color = Color(0,0,0,0)
	
	if _current_scene.camera_finish_position:
		camera.offset = _current_scene.camera_finish_position
	
	var animation = animation_player.get_animation("start")
	animation.track_set_key_value(2, 0, Vector2.ZERO)
	animation.track_set_key_value(2, 1, Vector2.ZERO)
