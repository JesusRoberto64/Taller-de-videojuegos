extends AnimatedSprite2D

var gravity = 25.0
var jump_force = 8.0
var velocity = 0.0

var floor_limit = 128.0

var crunch : bool
@onready var area = $Area2D/CollisionShape2D
@onready var area_crunch = $Area2D/CollisionShape2D2

func _physics_process(delta):
	crunch = Input.is_action_pressed("ui_down")
	if position.y >= floor_limit:
		velocity = 0.0
		if Input.is_action_just_pressed("ui_accept") and position.y >= floor_limit:
			velocity -= jump_force
	
	velocity += gravity * delta
	position.y += velocity
	
	position.y = min(floor_limit, position.y) 
	handle_collison()

func _process(_delta):
	if position.y >= floor_limit:
		if crunch:
			play("crunch")
		else:
			play("run")
	else:
		if velocity >= 0.0:
			play("fall")
		else:
			play("jump")

func handle_collison():
	if crunch and position.y >= floor_limit:
		area.disabled = true
		area_crunch.disabled = false
	else:
		area.disabled = false
		area_crunch.disabled = true
