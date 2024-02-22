extends CharacterBody2D

var power = 100
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var axis = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):

	move()
	
func move():
	$Body.apply_impulse(Vector2.ZERO, Vector2.RIGHT * power)
	$LegLeft.apply_impulse(Vector2.ZERO, Vector2.RIGHT * power)
	$LegRight.apply_impulse(Vector2.ZERO, Vector2.RIGHT * power)
	
