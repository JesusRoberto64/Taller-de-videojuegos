## weight body interaction
extends Node

var Body : CharacterBody2D = null
@export var object_weight : float = 15.0
var weight : float = 0.0
var softness = 750.0

var has_upper_body = false

func _ready() -> void:
	Body = get_parent()
	Body.add_to_group("weight_body")
	weight = object_weight

func _physics_process(_delta: float) -> void:
	var collision = Body.move_and_collide(Vector2.DOWN, true, 0.01)
	if collision != null:
		var collider = collision.get_collider()
		var collision_normal = collision.get_normal()
		if collider.is_in_group("weight_body") and collision_normal.y < 0.0:
			collider.interaction(Body)
	
	if Body.get_slide_collision_count() > 0:
		var c = Body.get_last_slide_collision()
		var collider = c.get_collider()
		var collision_normal = c.get_normal()
		
		if collider.is_in_group("weight_box") and abs(collision_normal.x) == 1.0:
			collider.push_move(collision_normal.x)
	
	if !has_upper_body: weight = object_weight
	has_upper_body = false

# Funcion recursiva cuando se tocan a ellos mismos.
func interaction(_body):
	has_upper_body = true
	weight = _body.get_weight() + object_weight

func get_weight() -> float:
	return weight
