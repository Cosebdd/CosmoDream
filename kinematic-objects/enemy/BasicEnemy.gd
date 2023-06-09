extends KinematicObject
class_name BasicEnemy

onready var body := $Body
onready var edge_ray := $Body/LedgeCheck
onready var patrol_delay_timer := $PatrolTimer
onready var attack_delay_timer := $AttackDelayTimer
onready var animation_player := $AnimationPlayer

onready var basic_collision := $BaseCollision

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
export(float) var attack_delay = 1.0

var _state = idle
var _player_to_follow: Player
var _is_attack_mode := false


func _ready() -> void:
	patrol_delay_timer.wait_time = patrol_delay
	attack_delay_timer.wait_time = attack_delay
	
	if basic_collision:
		body.add_child(basic_collision)


func _physics_process(delta: float) -> void:
	match _state:
		idle: _idle()
		move: _move()
		attack: _attack()
	
	if _is_attack_mode: return
	
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
	
	if _is_attack_mode:
		_state = attack


func _move() -> void:
	animation_player.play("Walk")
	
	if velocity.x == 0:
		_state = idle
	
	if _is_attack_mode:
		_state = attack


func _attack() -> void:
	if attack_delay_timer.is_stopped():
		animation_player.play("Attack")
		yield(animation_player, "animation_finished")
		attack_delay_timer.start()
	_state = idle
