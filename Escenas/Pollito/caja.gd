## BOX
extends AnimatableBody2D

var gravity = 10.0
var velocity : Vector2 = Vector2.ZERO
var is_moving =  false
var on_floor = false

@export var object_weight : float = 15.0
var weight : float = 0.0
var softness = 750.0
var has_upper_body = false

func _ready() -> void:
	add_to_group("weight_body")
	add_to_group("weight_box")
	weight = object_weight

func _physics_process(delta: float) -> void:
	
	if not on_floor:
		velocity.y += gravity
	else:
		velocity.y = 0.0
	
	if not is_moving:
		velocity.x = 0.0
	is_moving = false
	
	# Movieinto horizontal
	move_and_collide(Vector2(velocity.x, 0.0) * delta)
	
	var collision = move_and_collide(Vector2.DOWN, true)
	on_floor = false
	if collision != null:
		var collider = collision.get_collider()
		var collision_normal = collision.get_normal()
		if collision_normal.y < 0.0:
			on_floor = true
		if collider.is_in_group("weight_body") and collision_normal.y < 0.0:
			collider.interaction(self)
	else:
		move_and_collide(Vector2(0.0, velocity.y) * delta)
	
	if !has_upper_body: weight = object_weight
	has_upper_body = false

func push_move(mov : float) -> void:
	is_moving = true
	velocity.x = -mov * (1.0 / weight) * softness

# Funcion recursiva cuando se tocan a ellos mismos.
func interaction(_object):
	has_upper_body = true
	weight = _object.weight + object_weight

func is_on_floor() -> bool:
	return on_floor

func get_weight() -> float:
	return weight

func set_floor_position(_position_y, _gravity : float = 10.0) -> void :
	position.y += _gravity
