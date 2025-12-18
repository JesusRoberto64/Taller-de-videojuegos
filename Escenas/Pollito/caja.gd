extends AnimatableBody2D

var gravity = 10.0
var velocity : Vector2 = Vector2.ZERO
var is_moving =  false
var on_floor = false

@onready var objectInteraction = $ObjectsInteraction

func _physics_process(delta: float) -> void:
	
	velocity.y += gravity
	
	if !is_moving:
		velocity.y = 0.0
		pass
	is_moving = false
	var collision = move_and_collide(velocity * gravity * delta)
	
	on_floor = false
	if collision != null:
		var collider = collision.get_collider()
		if collision.get_normal().y < 0.0:
			on_floor = true

func set_move(mov) -> void:
	is_moving = true
	velocity.x = mov

func is_on_floor() -> bool:
	return on_floor

func get_weight() -> float:
	return objectInteraction.weight
