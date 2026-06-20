extends CharacterBody3D

const gravity = 0.180
const JUMP_SPEED = 5.80
const MAX_SPEED = 2.0
const ACCEL = 1.0

var dir : Vector3 = Vector3.ZERO

const DEACCEL = 0.08

@onready var camera = $Rotation_Helper/Camera3D
@onready var rotation_helper = $Rotation_Helper

var MOUSE_SENSITIVITY = 1.0

var floor_limit = 0.0

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _physics_process(_delta):
	dir = Vector3.ZERO
	var camera_xform = camera.get_global_transform()
	var input_movement_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	dir += camera_xform.basis.z * input_movement_vector.y
	dir += camera_xform.basis.x * input_movement_vector.x 
	dir.y = 0.0
	dir = dir.normalized()
	
	velocity.y -= gravity
	# Jump
	if is_on_floor() or position.y <= floor_limit:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_SPEED
	
	var hvel = velocity
	hvel.y = 0.0
	var target = dir
	target *= MAX_SPEED
	
	var accel: float
	if dir.dot(hvel) > 0.0:
		accel = ACCEL
	else:
		accel = DEACCEL
	
	hvel = hvel.slerp(target, accel)
	#hvel = dir * MAX_SPEED
	velocity.x = hvel.x
	velocity.z = hvel.z
	move_and_slide()
	
	position.y = max(floor_limit, position.y)

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_x(deg_to_rad(event.relative.y * MOUSE_SENSITIVITY))
		self.rotate_y(deg_to_rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		
		var camera_rot = rotation_helper.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		rotation_helper.rotation_degrees = camera_rot
