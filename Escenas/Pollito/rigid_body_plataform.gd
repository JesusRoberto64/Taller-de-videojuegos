extends RigidBody2D

func _ready() -> void:
	contact_monitor =  true
	max_contacts_reported = 5

func _physics_process(delta: float) -> void:
	
	var collision = move_and_collide(Vector2.UP * 5.0, true)
	if collision != null:
		var collider = collision.get_collider()
		
		print(get_colliding_bodies())
		
		
		#print(collision)
	
	pass
