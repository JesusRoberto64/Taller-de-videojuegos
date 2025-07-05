extends AnimatedSprite2D

@export_range(1.0, 300.0) var velocity = 100.0

func _process(delta: float) -> void:
	var mov = Vector2.ZERO
	# Botones para izquerda y derecha
	if Input.is_action_pressed("ui_right"):
		mov.x = mov.x + velocity * delta
		flip_h = false # cambia la dirección del sprite
		pass
	elif Input.is_action_pressed("ui_left"):
		mov.x = mov.x - velocity * delta
		flip_h = true # cambia la dirección del sprite
		pass
	# Botones para arriba y abajo
	if Input.is_action_pressed("ui_down"):
		mov.y = mov.y + velocity * delta
		pass
	elif Input.is_action_pressed("ui_up"):
		mov.y = mov.y - velocity * delta
		pass
	
	position += mov
	screen_limit()
	pass

func screen_limit() -> void:
	var margin = 10.0
	var viewport_size = get_viewport_rect().size
	position.x = clamp(position.x, margin, viewport_size.x - margin)
	position.y = clamp(position.y, margin, viewport_size.y - margin)
	pass
