extends AnimatableBody2D

var balance

func _ready() -> void:
	balance = get_parent()
	add_to_group("balance_platform")

func _physics_process(delta):
	if get_collision_exceptions().size() > 0:
		balance.counter_weight(get_collision_exceptions(), delta)
	else:
		balance.is_interacting = false
	
	for body in get_collision_exceptions():
		remove_collision_exception_with(body)
	
	for col in 10: # Las veces maximas que se revisan las colisiones.
		var collision = move_and_collide(Vector2.UP * 5.0, true)
		if collision != null:
			var collider = collision.get_collider()
			if collider.is_in_group("weight_body") and collider.is_on_floor():
				add_collision_exception_with(collider)
		else:
			break
