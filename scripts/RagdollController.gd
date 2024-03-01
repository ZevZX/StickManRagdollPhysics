extends Node2D

var moveSpeed = 300
const jumpHeight = 9900
var jumpAble = false
var jumpNumber = 0
var jumpLimit = 0

# Limb Controls
var limbs = []

func _ready():
	for limb in get_children():
		if limb is Limb: limbs.append(limb)

func _physics_process(delta):
	var axis = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var axis_y = - Input.get_action_strength("ui_down")
	$Limbs/Torso.apply_impulse(Vector2.RIGHT * axis * moveSpeed, Vector2.ZERO)
	$Limbs/Torso.apply_impulse(Vector2.UP * 5 * axis_y * moveSpeed, Vector2.ZERO)
	# Jumping
	if Input.is_action_just_pressed("ui_up") and jumpAble and jumpLimit < 2:
		$Limbs/Torso.apply_impulse(Vector2.UP * jumpHeight, Vector2.ZERO)
		jumpLimit += 1
		print(jumpLimit)

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

func _on_area_2d_body_entered(body):
	if body.is_in_group("ground"):
		jumpAble = true
		print('can jump')
		jumpNumber += 1

func _on_area_2d_body_exited(body):
	if body.is_in_group("ground"):
		jumpNumber -= 1
		if jumpNumber == 0:
			jumpAble = false
			print('cant jump')
			if jumpLimit == 2:
				jumpLimit -= 2
