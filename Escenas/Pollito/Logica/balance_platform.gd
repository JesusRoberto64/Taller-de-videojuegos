extends AnimatableBody2D

var Balance = null
var half_height = 2.0 # La altura de la plataforma desde el punto de origen. 

func _ready() -> void:
	Balance = get_parent()

func _physics_process(delta):
	if get_collision_exceptions().size() > 0:
		Balance.counter_weight(get_collision_exceptions(), delta)
	else:
		Balance.is_interacting = false
	
	for body in get_collision_exceptions():
		remove_collision_exception_with(body)
	
	for col in 10: # Las veces maximas que se revisan las colisiones.
		var collision = move_and_collide(Vector2.UP * 5.0, true)
		if collision != null:
			var collider = collision.get_collider()
			if collider.is_in_group("weight_body") and collision.get_normal().y > 0.0:
				add_collision_exception_with(collider)
				collider.snap_floor_position(global_position.y, half_height)
		else:
			break
