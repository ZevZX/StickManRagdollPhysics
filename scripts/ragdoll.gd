extends Node2D

var power = 200

func _physics_process(_delta):
	var axis = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var axis_y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	$Body.apply_impulse(Vector2.RIGHT * axis * power, Vector2.ZERO)
	$Body.apply_impulse(Vector2.UP * axis_y * power, Vector2.ZERO)
