extends KinematicObject
class_name VirusSpider

onready var body := $Body
onready var edge_ray := $Body/RayCast2D
onready var patrol_delay_timer := $Timer
onready var animation_player := $AnimationPlayer

enum Directions {
	left = -1
	right = 1
}

enum {
	idle,
	attack,
	move,
}

export(Directions) var direction = Directions.right
export(float) var patrol_delay = 1.0

var _state = idle
var _player_to_follow: Player


func _ready() -> void:
	patrol_delay_timer.wait_time = patrol_delay


func _physics_process(delta: float) -> void:
	match _state:
		idle: _idle()
		move: _move()
		attack: _attack()
	
	apply_gravity()
	
	var can_move = edge_ray.is_colliding()
	var is_just_turned = body.scale.x != direction
	body.scale.x = direction
	var _direction = Vector2(
		direction if can_move else 0,
		0
	)
	
	process(_direction, delta)
	
	if not is_on_floor(): return
	
	if _player_to_follow:
		direction = Directions.right if _player_to_follow.position.x > position.x else Directions.left 
		return
	
	if not is_just_turned and (velocity.x == 0 or not edge_ray.is_colliding()):
		if not _player_to_follow and patrol_delay_timer.is_stopped():
			patrol_delay_timer.start()


func _idle() -> void:
	animation_player.play("Idle")
	
	if velocity.x != 0:
		_state = move


func _move() -> void:
	animation_player.play("Walk")
	
	if velocity.x == 0:
		_state = idle


func _attack() -> void:
	animation_player.play("Attack")
	yield(animation_player, "animation_finished")
	_state = idle


func _on_delay_timer() -> void:
	direction *= -1


func _on_Awareness_player_inside(player: Player) -> void:
	_player_to_follow = player


func _on_Awareness_player_outside():
	_player_to_follow = null
#	if not edge_ray.is_colliding():
#		direction *= -1
