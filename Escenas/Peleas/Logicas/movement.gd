extends Node

var player : CharacterBody2D = null

@export var speed : float = 100.0
@export var fall_gravity = 23.0
@export var base_gravity = 18.0
@export var jump = 460.0

var direction : Vector2 = Vector2.LEFT
var movement : Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	movement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	direction.x = movement.x if movement != Vector2.ZERO else direction.x

func move() -> void:
	if !player.is_on_floor():
		var gravity = base_gravity if player.velocity.y < 0.0 else fall_gravity
		player.velocity.y += gravity
	else:
		player.velocity.y = 0.0
		player.jumping = false
		if Input.is_action_just_pressed("ui_up"):
			player.velocity.y = -jump
			player.jumping = true
	
	if movement.y <= 0.0: # Si NO está agachado
		player.velocity.x = movement.x * speed
	else:
		player.velocity.x = 0.0
		pass
	
	player.move_and_slide()
