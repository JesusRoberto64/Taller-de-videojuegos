extends CharacterBody2D

var accel = Vector2.ZERO

@export_range(0.0, 250.0) var speed = 20.0
@export var MAX_ACCEL = 7.0
@export var releace_time = 0.25

@onready var sprite_anim: AnimatedSprite2D = $sprite_anim
@onready var cam = $Camera2D
var direction : float = 1.0
var mov_anim : Vector2 = Vector2.ZERO

var dash_timer: float = 0.8
var is_dashing : bool = false
var BASE_ACCEL = 7.0

var vec_direction : Vector2 = Vector2.RIGHT
var is_flipping : bool = false

func _ready() -> void:
	BASE_ACCEL = MAX_ACCEL

func _physics_process(delta: float) -> void:
	var last_direction = direction
	var mov = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if not is_flipping:
		mov_anim = mov
		if mov != Vector2.ZERO:
			#Cambiar la direccion de sprite
			if mov.x != 0.0:
				#sprite_anim.flip_h = true if mov.x < 0.0 else false
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
	cam.offset_movement(mov, delta)
	
	position.y = clamp(position.y, 0.0 ,180.0)
	
	vec_direction = mov if mov != Vector2.ZERO else vec_direction
	
	var changed_direction = false
	if last_direction != direction and not is_flipping:
		changed_direction = true
		is_flipping = true
	elif is_flipping:
		print(direction)
		if direction < 0.0:
			sprite_anim.rotation = lerp_angle(sprite_anim.rotation, PI , delta)
		else:
			print(sprite_anim.rotation)
			sprite_anim.rotation = lerp_angle(sprite_anim.rotation, 0.0 , delta)
		return
		
		#if last_direction < 0.0:
			#var flip_direction = atan2(vec_direction.y, vec_direction.x)
			#print(flip_direction)
			#pass
			#if sprite_anim.rotation > -PI / 2.0:
				#sprite_anim.rotation = lerp_angle(sprite_anim.rotation, -PI / 1.8, delta * 10.0)
				#velocity = Vector2(0.0, -100.0)
			#else:
				#sprite_anim.rotation = lerp_angle(sprite_anim.rotation, -PI , delta * 0.0)
				#velocity = Vector2.ZERO
			#print(sprite_anim.rotation)
			#move_and_slide()
			#pass
		#else:
			#sprite_anim.rotation = lerp_angle(sprite_anim.rotation, 0.0, delta)
			#pass
		#
		#
		#pass
	
	if mov.x != 0.0:
		var target_direction = atan2(vec_direction.y, vec_direction.x)
		sprite_anim.rotation = lerp_angle(sprite_anim.rotation, target_direction, delta)
	else:
		var hover_direction = atan2(0.0, vec_direction.x)
		sprite_anim.rotation = lerp_angle(sprite_anim.rotation, hover_direction, delta)
	

func dash(delta) -> void:
	if not is_dashing: return 
	dash_timer -= delta
	if dash_timer <= 0.0:
		MAX_ACCEL = BASE_ACCEL
		is_dashing = false
		pass
	pass
