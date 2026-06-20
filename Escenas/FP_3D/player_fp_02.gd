extends CharacterBody3D

const gravity = 0.180
const JUMP_SPEED = 5.80
const MAX_SPEED = 2.0
var MOUSE_SENSITIVITY = 0.01

@onready var camera = $Rotation_Helper/Camera3D
@onready var rotation_helper = $Rotation_Helper

var floor_limit = 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(_delta):
	var move_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	move_dir = (rotation_helper.basis*Vector3(move_dir.x,0.0, move_dir.y)).normalized()
	
	velocity.y -= gravity
	# Jump
	if is_on_floor() or position.y <= floor_limit:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_SPEED
	
	var h_velocity = move_dir * MAX_SPEED
	velocity = Vector3(h_velocity.x, velocity.y, h_velocity.z)
	
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
		rotation_helper.rotate_y(event.relative.x * MOUSE_SENSITIVITY * -1.0)
		camera.rotate_x(event.relative.y * MOUSE_SENSITIVITY * -1.0)
		camera.rotation.x = clampf(camera.rotation.x, deg_to_rad(-80.0), deg_to_rad(80.0))
