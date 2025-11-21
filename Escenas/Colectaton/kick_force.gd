extends Node

@export var ball : RigidBody2D = null
var player : CharacterBody2D = null

func _ready() -> void:
	player = get_parent()

func _physics_process(delta: float) -> void:
	var contact = false
	if player.position.distance_to(ball.position) < 20.0:
		contact = true
	
	if contact:
		ball.apply_impulse(player.direction)
		if Input.is_action_just_pressed('ui_accept'):
			ball.apply_impulse(player.direction * 50.0)
		
		
	
	pass
