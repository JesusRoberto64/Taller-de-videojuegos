## weight body interaction
extends Node

var collider = null
var collision_normal : Vector2 = Vector2.ZERO
var player : CharacterBody2D = null
@export var object_weight : float = 15.0
var weight = 5.0

func _ready() -> void:
	player = get_parent()
	player.get_node("CollisionShape2D").add_to_group("weight_body")
	weight = object_weight

func _physics_process(_delta: float) -> void:
	
	for i in player.get_slide_collision_count():
		var collision = player.get_slide_collision(i)
		
		var collider = collision.get_collider()
		if collider.is_in_group("weight_body"):
			collider.interaction(self)
		print(collider.name)
		
	
	#var collision = player.get_last_slide_collision()
	#if collision != null:
		#collider = collision.get_collider()
		#collision_normal = collision.get_normal()
		#if collision_normal.y < 0.0 and collider.is_in_group("weight_body"):
			#collider.get_parent().interaction(self)
	#else:
		#weight = object_weight

# Funcion recursiva cuando se tocan a ellos mismos.
func interaction(_object):
	if _object.has_method("interaction"):
		weight += _object.weight
