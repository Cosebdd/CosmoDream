extends Resource
class_name CutSceneData

export(Texture) var scene_image
export(Vector2) var camera_initial_position = Vector2.ZERO
export(Vector2) var camera_finish_position = Vector2.ZERO
export(Vector2) var image_scale = Vector2(1, 1)
export(String, MULTILINE) var text
export(int) var textbox_height = 40
