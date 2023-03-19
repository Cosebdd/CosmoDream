extends Ability
class_name ShootingAbility

export(int) var spread_angle = 15
export(int) var fragment_number = 7
export(float) var max_fragment_spawn_delay = 0.1
export(float) var y_spawn_offset = 0.0
export(float) var x_spawn_offset = 0.0

var Bullet = preload("res://abilities/list/shooting/bullet/Bullet.tscn")

signal shot_started;

func _ready():
	randomize()
	var player = get_tree().root.find_node("Player", true, false)
	connect("shot_started", player, "_on_Shot_Started")

func _fire_implementation():
	_shot()


func _shot() -> void:
	emit_signal("shot_started")
	for _i in range(fragment_number):
		var bullet = _generate_fragment()
		get_tree().root.get_child(0).add_child(bullet)


func _generate_fragment() -> Bullet:
	var angle_sign = randi() % 2
	if angle_sign == 0: angle_sign = -1
	var random_angle = float(
		(randi() % (int(deg2rad(spread_angle) * 1000))) + 1
	) / 1000 * angle_sign
	
	var spawn_delay = float(
		randi() % int(max_fragment_spawn_delay * 1000) + 1
	) / 1000
	
	var offset_x = (x_spawn_offset + _owner.size_rect.size.x) * _owner.direction.x
	
	var owner_center_position = Vector2(
		_owner.size_rect.position.x + _owner.size_rect.size.x / 2 + offset_x,
		_owner.size_rect.position.y + _owner.size_rect.size.y / 2 + y_spawn_offset
	)
	var bullet = Bullet.instance()
	bullet.is_safe_for_player = true
	bullet.set_direction(_owner.direction.rotated(random_angle))
	bullet.set_spawn_delay(spawn_delay)
	bullet.global_position = global_position + owner_center_position
	
	return bullet
