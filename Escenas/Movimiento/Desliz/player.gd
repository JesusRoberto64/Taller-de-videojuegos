extends AnimatedSprite2D

var accel = Vector2.ZERO
@export_range(0.0, 250.0) var velocity = 20.0
@export var MAX_ACCEL = 7.0
@export var releace_time = 0.25

func _process(delta: float) -> void:
	var mov = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if mov != Vector2.ZERO:
		#Cambiar la direccion de sprite
		if mov.x != 0.0:
			flip_h = true if mov.x < 0.0 else false
		
		accel += mov * velocity * delta
		if accel.length() > MAX_ACCEL:
			accel = accel.normalized() * MAX_ACCEL
	else:
		var decel_amout = (MAX_ACCEL / releace_time) * delta
		accel = accel.move_toward(Vector2.ZERO, decel_amout)
		pass
	
	position += accel
	screen_limit()
	pass

func screen_limit() -> void:
	var margin = 10.0
	var viewport_size = get_viewport_rect().size
	position.x = clamp(position.x, margin, viewport_size.x - margin)
	position.y = clamp(position.y, margin, viewport_size.y - margin)
	pass
