extends CharacterBody2D

var accel = Vector2.ZERO
@export_range(0.0, 250.0) var speed = 20.0
@export var MAX_ACCEL = 7.0
@export var releace_time = 0.25

@onready var sprite_anim: AnimatedSprite2D = $sprite_anim

func _process(delta: float) -> void:
	var mov = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if mov != Vector2.ZERO:
		#Cambiar la direccion de sprite
		if mov.x != 0.0:
			sprite_anim.flip_h = true if mov.x < 0.0 else false
		
		accel += mov * speed
		if accel.length() > MAX_ACCEL:
			accel = accel.normalized() * MAX_ACCEL
		sprite_anim.speed_scale = 1.5;
	else:
		var decel_amout = (MAX_ACCEL / releace_time) * delta
		accel = accel.move_toward(Vector2.ZERO, decel_amout)
		sprite_anim.speed_scale = 0.5;
		pass
	
	#position += accel
	velocity = accel
	move_and_slide()
	screen_limit()
	pass

func screen_limit() -> void:
	var margin = 10.0
	position.y = clamp(position.y, margin, (860.0) - margin)
	pass
