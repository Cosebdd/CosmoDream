extends Node2D
class_name Ability

export(int) var level = 1
export(int) var max_level = 3
export(int) var charge_limit = null # says how many shots we have
export(int) var recharge_value = 1
export(float) var recharge_time = null # says how long is reloading
export(bool) var recharge_after_fully_empty = false
export(float) var fire_delay = null # set the delay between 2 fires when button is pressed

var active := false
onready var _charges: int = charge_limit
var _is_delay_between := false
var _recharge_timer: Timer = null
var _delay_timer: Timer = null
var _direction: Vector2 = Vector2.ZERO


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
	if not active or _is_delay_between: return
	_execute()


func _execute() -> void:
	if _recharge_timer and not _recharge_timer.is_processing():
		if (recharge_after_fully_empty and _charges == 0) or (not recharge_after_fully_empty and _charges < charge_limit):
			_recharge_timer.start()

	if _delay_timer and _charges != null and _charges > 0:
		_delay_timer.start()
		_is_delay_between = true
		_charges = clamp(_charges - 1, 0, charge_limit)


func upgrade(levels: int) -> void:
	level = clamp(level + levels, 0, max_level)


func activate(direction: Vector2) -> void:
	active = true
	_direction = direction


func deactivate() -> void:
	active = false


func _handle_recharge_timeout() -> void:
	_charges = clamp(_charges + recharge_value, 0, charge_limit)
	if _charges < charge_limit: _recharge_timer.start()


func _handle_delay_timeout() -> void:
	_is_delay_between = false
