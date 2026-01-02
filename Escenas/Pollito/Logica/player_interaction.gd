## Interacción para el Jugador
extends BodyInteraction

func add_push_force() -> void:
	if Body.get_slide_collision_count() > 0:
		var c = Body.get_last_slide_collision()
		var collider = c.get_collider()
		var collision_normal = c.get_normal()
		if collider.is_in_group("weight_box") and abs(collision_normal.x) == 1.0:
			collider.push_move(collision_normal.x)
		elif collider.is_in_group("handle"):
			collider.move_handle(Vector2(collision_normal))
