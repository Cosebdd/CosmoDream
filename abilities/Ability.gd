extends Node2D
class_name Ability

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
	if not active or is_delay_timer_run or is_recharge_rimer_run: return
	
	_execute()


func _execute() -> void:
	match _state:
		fire:
			_fire()
		delay:
			_delay()
		full_recharge:
			_full_recharge()


func _full_recharge() -> void:
	if not _recharge_timer.is_stopped(): return
	_recharge_timer.start()


func _delay() -> void:
	if not _delay_timer.is_stopped(): return
	_delay_timer.start()


func _fire_implementation() -> void:
	print("Implement _fire_implementation method for your Ability")

func _fire() -> void:
	if _charges != null:
		_charges = clamp(_charges - 1, 0, charge_limit)
	
	if _charges != null and _charges == 0:
		_state = full_recharge
		return
	
	if fire_delay != null:
		_state = delay
	
	_fire_implementation()


func upgrade(levels: int) -> void:
	level = clamp(level + levels, 0, max_level)


func set_owner(owner_body) -> void:
	_owner = owner_body


func activate() -> void:
	active = true


func deactivate() -> void:
	active = false


func _handle_recharge_timeout() -> void:
	_charges = clamp(recharge_value, 0, charge_limit)
	_state = fire


func _handle_delay_timeout() -> void:
	_state = fire
