extends Node2D
class_name Ability

signal hp_updated(hp)
signal ability_recharge(timeout)
signal charges_updated(charges)

export(Texture) var picture = preload("res://icon.png")
export(bool) var is_internal_ability = false # if true - the ability will be rendered inside of object
export(int) var level = 1
export(int) var max_level = 3
export(int) var charge_limit = null # says how many shots we have
export(int) var recharge_value = 1
export(float) var recharge_time = null # says how long is reloading
export(bool) var recharge_after_fully_empty = false
export(float) var fire_delay = null # set the delay between 2 fires when button is pressed


enum {
	full_recharge,
	delay,
	fire,
}

onready var _charges = charge_limit
var active := false
var _recharge_timer: Timer = null
var _delay_timer: Timer = null
var _owner
var _state = fire
var max_health: int = Config.get_ability_max_health()
var _health = max_health


func _ready():
	
	if charge_limit != null and charge_limit > 0 and recharge_time != null and recharge_time > 0.0:
		_recharge_timer = Timer.new()
		_recharge_timer.wait_time = recharge_time
		_recharge_timer.one_shot = true
		_recharge_timer.connect("timeout", self, "_handle_recharge_timeout")
		add_child(_recharge_timer)
	
	if fire_delay != null and fire_delay > 0.0:
		_delay_timer = Timer.new()
		_delay_timer.wait_time = fire_delay
		_delay_timer.one_shot = true
		_delay_timer.connect("timeout", self, "_handle_delay_timeout")
		add_child(_delay_timer)


func _process(_delta):
	var is_delay_timer_run = _delay_timer && !_delay_timer.is_stopped()
	var is_recharge_rimer_run = _recharge_timer && !_recharge_timer.is_stopped()
	
	if (not active and _state != full_recharge) or is_delay_timer_run or is_recharge_rimer_run or is_destroyed(): return
	
	_execute()


func is_destroyed() -> bool:
	return _health <= 0


func get_damage(damage: int) -> void:
	_health = clamp(_health - damage, 0, max_health)

func update_health(health: int) -> void:
	assert(max_health != null, "max_health is null")
	_health = clamp(health, 0, max_health)

func _execute() -> void:
	match _state:
		fire:
			_fire()
		delay:
			_delay()
		full_recharge:
			_full_recharge()


func _full_recharge() -> void:
	if _charges != null and _charges == 0:
		active = false
	
	if not _recharge_timer.is_stopped(): return
	_recharge_timer.start()
	emit_signal("ability_recharge", _recharge_timer.time_left)


func _delay() -> void:
	if not _delay_timer.is_stopped(): return
	_delay_timer.start()


func _fire_implementation() -> void:
	print("Implement _fire_implementation method for your Ability")

func _fire() -> void:
	if _charges != null and _charges > 0 and fire_delay != null:
		_fire_implementation()

	if _charges != null:
		_charges = clamp(_charges - 1, 0, charge_limit)
		emit_signal("charges_updated", _charges)
	
	if _charges != null and _charges == 0:
		_state = full_recharge
		return
	
	if fire_delay != null:
		_state = delay



func upgrade(levels: int) -> void:
	level = clamp(level + levels, 0, max_level)


func set_owner(owner_body) -> void:
	_owner = owner_body


func activate() -> void:
	if _charges != 0:
		if _recharge_timer != null: _recharge_timer.stop()
		active = true


func deactivate() -> void:
	active = false
	if _recharge_timer != null and _state != full_recharge: _recharge_timer.start()


func _handle_recharge_timeout() -> void:
	_charges = clamp(_charges + recharge_value, 0, charge_limit)
	emit_signal("charges_updated", _charges)
	_state = fire
	if _charges < charge_limit and not recharge_after_fully_empty:
		_recharge_timer.start()


func _handle_delay_timeout() -> void:
	_state = fire
