extends Node

var player : CharacterBody2D = null
var opponent : CharacterBody2D = null

@export var speed : float = 100.0
@export var fall_gravity = 23.0
@export var base_gravity = 18.0
@export var jump = 460.0
var direction : Vector2 = Vector2.LEFT 

func set_overlord(overlord: CharacterBody2D) -> void:
	player = overlord
	var players = get_tree().get_nodes_in_group("Player")
	for p in players:
		if p != player:
			opponent = p

func _physics_process(_delta: float) -> void:
	var mov = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	direction.x = mov.x if mov != Vector2.ZERO else direction.x
	
	if !player.is_on_floor():
		var gravity = base_gravity if player.velocity.y < 0.0 else fall_gravity
		player.velocity.y += gravity
	else:
		player.velocity.y = 0.0
		if Input.is_action_just_pressed("jump"):
			player.velocity.y = -jump
	
	player.velocity.x = mov.x * speed
	player.move_and_slide()
