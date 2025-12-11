## Balance Object
extends Node2D

@onready var platform : AnimatableBody2D = $Balance 
@onready var door : AnimatableBody2D = $Door

@export var lenght = 30.0
@export var weight = 50.0
var platform_pos : Vector2
var door_pos : Vector2

var is_interacting = false
var interacting_count = 0

var bodies : Array = []

func _ready() -> void:
	platform_pos = platform.position
	door_pos = door.position
	platform.add_to_group("weight_body")

func _physics_process(delta: float) -> void:
	if is_interacting:
		var against_weight = 0.0
		for i in bodies.size(): 
			against_weight += bodies[i].weight
		
		if platform.position.y - platform_pos.y < lenght:
			platform.position.y += delta * against_weight
			door.position.y -= delta * against_weight
	else:
		if platform.position.y > platform_pos.y:
			platform.position.y -= delta * weight
			door.position.y += delta * weight
		bodies.clear()
	
	is_interacting = false

func interaction(body):
	if !bodies.has(body):
		bodies.append(body)
	is_interacting = true
