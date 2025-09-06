extends CharacterBody2D

var speed = 100
@onready var sprite_anim = $AnimatedSprite2D

func _process(_delta: float) -> void:
	var mov = Vector2.ZERO
	# Botones para izquierda y derecha
	if Input.is_action_pressed("ui_right"):
		mov.x = 1.0
		sprite_anim.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		mov.x = -1.0
		sprite_anim.flip_h = true
	
	if Input.is_action_pressed("ui_up"):
		mov.y = -1.0
	if Input.is_action_pressed("ui_down"):
		mov.y = 1.0
	
	velocity = mov * speed
	move_and_slide()
	if mov != Vector2.ZERO:
		sprite_anim.play("walking")
	else:
		sprite_anim.play("idle")
