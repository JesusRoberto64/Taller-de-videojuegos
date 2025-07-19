extends AnimatedSprite2D

@export_range(1.0, 300.0) var velocity = 100.0

func _process(delta: float) -> void:
	var mov = Vector2.ZERO
	
	# Botones para izquerda y derecha
	if Input.is_action_pressed("ui_right"):
		mov.x = mov.x + velocity * delta
		flip_h = false # cambia la dirección del sprite
		$Shadow.offset.x = -8.0
		pass
	elif Input.is_action_pressed("ui_left"):
		mov.x = mov.x - velocity * delta
		flip_h = true # cambia la dirección del sprite
		$Shadow.offset.x = -4.0
		pass
	
	# Botones para arriba y abajo
	if Input.is_action_pressed("ui_down"):
		mov.y = mov.y + velocity * delta
		pass
	elif Input.is_action_pressed("ui_up"):
		mov.y = mov.y - velocity * delta
		pass
	
	position += mov
	# Animación 
	if mov != Vector2.ZERO:
		play("walk")
	else:
		play("idle")
	pass
