## Balance Object
extends Node2D

@onready var platform : AnimatableBody2D = $Platform 
@onready var door : AnimatableBody2D = $Door
@onready var register_platform : AnimatableBody2D = $Register

@export var lenght = 30.0
@export var weight = 30.0
var gravity = 50.0
var platform_pos : Vector2
var door_pos : Vector2

var is_interacting = false

func _ready() -> void:
	platform_pos = platform.position
	door_pos = door.position
	register_platform.position = platform.position

func _physics_process(delta: float) -> void:
	# Para regresar al peso de la puerta.
	if not is_interacting:
		if platform.position.y > platform_pos.y:
			platform.position.y -= delta * gravity
		if door.position.y < door_pos.y:
			door.position.y += delta * gravity
		pass
	register_platform.position = platform.position
	is_interacting = false

func counter_weight(_bodies, delta):
	var against_weight = 0.0
	for i in _bodies: 
		against_weight += i.get_weight()
	
	if against_weight < weight:
		is_interacting = false
		return
	
	is_interacting = true
	if platform.position.y - platform_pos.y < lenght:
		platform.position.y += delta * gravity
	if door.position.y > door_pos.y - lenght:
		door.position.y -= delta * gravity
