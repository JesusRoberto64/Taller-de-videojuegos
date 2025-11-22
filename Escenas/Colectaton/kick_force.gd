extends Node

@export var ball : RigidBody2D = null
var player : CharacterBody2D = null
var kick_force = 180.0

var spaw_pos : Vector2
var is_spawn = false
var vanish_ball = null
var inst_ball = preload('res://Escenas/Colectaton/ball.tscn')

func _ready() -> void:
	player = get_parent()
	spaw_pos = ball.position

func _physics_process(_delta: float) -> void:
	var contact = false
	if player.position.distance_to(ball.position) < 20.0:
		contact = true
	if contact:
		ball.apply_impulse(player.direction)
		if Input.is_action_just_pressed('ui_accept'):
			ball.kicked(player.direction * kick_force)
	
	if is_spawn:
		is_spawn = false
		vanish_ball.queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_cancel'):
		factory()
		pass

func factory() -> void:
	var new = inst_ball.instantiate()
	new.position = spaw_pos
	ball.sleeping = true
	ball.get_parent().add_child(new)
	vanish_ball = ball
	ball = new
	is_spawn = true
