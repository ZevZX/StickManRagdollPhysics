extends Node2D

var power = 500
const JUMP_VELOCITY = 20
var can_jump = true
# Limb Controls
var limbs = []

func _ready():
	for limb in get_children():
		if limb is Limb: limbs.append(limb)

func _physics_process(delta):
	var axis = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var axis_y = - Input.get_action_strength("ui_down")
	$Limbs/Torso.apply_impulse(Vector2.RIGHT * axis * power, Vector2.ZERO)
	$Limbs/Torso.apply_impulse(Vector2.UP * axis_y * power, Vector2.ZERO)
	
	# Jumping
	if Input.is_action_just_pressed("ui_up") and can_jump:
		$Limbs/Torso.apply_impulse(Vector2.UP * JUMP_VELOCITY * power, Vector2.ZERO)
		
	# Loop Over All Limbs
	for limb in $Limbs.get_children():
		if limb is Limb && limb.enabled == true:
			var current_angle = limb.rotation;
			
			var heading_vector = Vector2.ZERO;
			heading_vector.x = cos(limb.desired_angle);
			heading_vector.y = sin(limb.desired_angle);
			
			var current_vector = Vector2.ZERO;
			current_vector.x = cos(current_angle);
			current_vector.y = sin(current_angle);
			
			var magnitude = current_vector.distance_to(heading_vector);
			var applied_force = limb.force;
			limb.angular_velocity = lerp_angle(current_angle, limb.desired_angle, (limb.force) * delta);

func _on_left_lower_leg_body_entered(body):
	print('a')
	if body.is_in_group("ground"):
		can_jump = true

func _on_left_lower_leg_body_exited(body):
	print('b')
	if body.is_in_group("ground"):
		can_jump = false

func _on_right_lower_leg_body_entered(body):
	print('c')
	if body.is_in_group("ground"):
		can_jump = true

func _on_right_lower_leg_body_exited(body):
	print('d')
	if body.is_in_group("ground"):
		can_jump = false
