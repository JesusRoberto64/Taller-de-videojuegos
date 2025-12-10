extends Node2D

@onready var platform : AnimatableBody2D = $Balance 
@onready var door : AnimatableBody2D = $Door

var weight = 50.0
var against_weight = 0.0
var platform_pos : Vector2
var door_pos : Vector2

var is_interacting = false
var interacting_count = 0

func _ready() -> void:
	platform_pos = platform.position
	door_pos = door.position

func _physics_process(delta: float) -> void:
	if is_interacting:
		platform.position.y += delta * weight
		door.position.y -= delta * weight
	else:
		if platform.position.y > platform_pos.y:
			platform.position.y -= delta * weight
			door.position.y += delta * weight 
	
	is_interacting = false

func interaction(delta):
	is_interacting = true
