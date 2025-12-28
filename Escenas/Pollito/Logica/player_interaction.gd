## weight body interaction
extends Node

var Player : CharacterBody2D = null
@export var object_weight : float = 15.0
var weight : float = 0.0
var softness = 750.0

var has_upper_body = false

func _ready() -> void:
	Player = get_parent()
	Player.add_to_group("weight_body")
	weight = object_weight

func _physics_process(_delta: float) -> void:
	for i in Player.get_slide_collision_count():
		var collision = Player.get_slide_collision(i)
		var collider = collision.get_collider()
		var collision_normal = collision.get_normal()
		
		if collider.is_in_group("weight_body") and collision_normal.y < 0.0:
			collider.interaction(self)
		elif collider.is_in_group("weight_box") and abs(collision_normal.x) > 0.0:
			collider.push_move(collision_normal.x)
	
	if !has_upper_body: weight = object_weight
	has_upper_body = false

# Funcion recursiva cuando se tocan a ellos mismos.
func interaction(_object):
	has_upper_body = true
	weight = _object.weight + object_weight

func get_weight() -> float:
	return weight
