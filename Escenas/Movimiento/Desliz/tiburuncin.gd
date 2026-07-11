extends CharacterBody2D

var speed = 50.0
var direction = -1.0
var distance = 80.0
var init_pos 

var radian = 0.0
var wave_speed = 5.0
var height = 30.0

@onready var anim_spr = $AnimatedSprite2D

func _ready():
	init_pos = position

func _physics_process(delta):
	velocity.x = speed * direction
	# Lógica de la ola
	radian += delta * wave_speed
	velocity.y = sin(radian) * height * wave_speed
	
	move_and_slide()
	
	# Cambio de direccion
	if abs(init_pos.x - position.x) >= distance:
		direction *= -1.0
	
	# Daño
	var collision = get_last_slide_collision()
	if collision != null:
		var collider = collision.get_collider()
		if collider is Dolphin:
			collider.hurt()

func _process(delta):
	anim_spr.flip_h = true if direction > 0.0 else false

func hurt():
	direction *= -1.0
