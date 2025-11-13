extends CharacterBody2D

var accel = Vector2.ZERO

@export_range(0.0, 250.0) var speed = 20.0
@export var MAX_ACCEL = 7.0
@export var releace_time = 0.25

@onready var sprite_anim: AnimatedSprite2D = $sprite_anim
@onready var cam = $Camera2D
var direction : float = 1.0
var mov_anim : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var mov = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	mov_anim = mov
	
	if mov != Vector2.ZERO:
		#Cambiar la direccion de sprite
		if mov.x != 0.0:
			sprite_anim.flip_h = true if mov.x < 0.0 else false
			direction = -1.0 if mov.x < 0.0 else 1.0
		
		accel += mov * speed
		if accel.length() > MAX_ACCEL:
			accel = accel.normalized() * MAX_ACCEL
		sprite_anim.speed_scale = 1.5;
	else:
		var decel_amout = (MAX_ACCEL / releace_time) * delta
		accel = accel.move_toward(Vector2.ZERO, decel_amout)
		sprite_anim.speed_scale = 0.5;
		pass
	
	
	velocity = accel
	move_and_slide()
	position.y = clamp(position.y, 0.0 ,180.0)
	cam.offset_movement(mov, delta)
	#position.x = wrapf(position.x, 0.0 , 320.0)
	
