extends Area2D

var force = 250.0
var height : float = 100.0
var direction : float = 1.0

var radian : float = 0.0
var pos : Vector2 = Vector2.ZERO

var gravity_force = 200.0
var gravity_up = 5.0

var timer = 2.0

func _ready():
	pos = position
	pass

func _physics_process(delta) -> void :
	timer -= delta
	if timer < 0.0:
		queue_free()
	
	if radian < PI / 1.9:
		radian += delta * gravity_up
		position.y = pos.y - abs(sin(radian)) * height
	else:
		gravity_force += delta * 150.0
		position.y += delta * gravity_force
	
	#
	if force > 0.0:
		position.x += delta * force * direction
		force = lerpf(force, 0.0, delta)
	

func set_parable(_direction, _force) -> void:
	force = _force
	direction = _direction

func missile() -> void:
	radian = PI
	pass
