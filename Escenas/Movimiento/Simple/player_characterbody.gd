extends CharacterBody2D

@export_range(1.0, 300.0) var speed = 100.0
@onready var sprite_anim = $player
@onready var shadow = $player/Shadow

func _process(_delta: float) -> void:
	var mov = Vector2.ZERO
	
	# Botones para izquerda y derecha
	if Input.is_action_pressed("ui_right"):
		mov.x = 1.0
		sprite_anim.flip_h = false # cambia la dirección del sprite
		shadow.offset.x = -8.00
	elif Input.is_action_pressed("ui_left"):
		mov.x = -1.0
		sprite_anim.flip_h = true # cambia la dirección del sprite
		shadow.offset.x = -4.0
	
	# Botones para arriba y abajo
	if Input.is_action_pressed("ui_down"):
		mov.y = 1.0
	elif Input.is_action_pressed("ui_up"):
		mov.y = -1.0
	
	velocity = mov.normalized() * speed # Velocidad final
	# Funcion que mueve el personaje tomando en cuenta su colisión.
	move_and_slide() 
	
	# Animación 
	if mov != Vector2.ZERO:
		sprite_anim.play("walk")
	else:
		sprite_anim.play("idle")
	pass
