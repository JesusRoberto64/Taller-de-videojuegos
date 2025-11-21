extends RigidBody2D

var dir = Vector2.RIGHT

func _ready() -> void:
	body_entered.connect(on_body_entered)
	contact_monitor = true
	pass

func _physics_process(delta):
	#apply_force(Vector2.LEFT)
	var kinematic = move_and_collide(dir)
	if kinematic != null:
		dir = kinematic.get_collider().direction
		print(dir)
	
	if get_contact_count() > 0:
		print(get_colliding_bodies())
	
	pass

func on_body_entered(body: Node) -> void:
	print(body)
	pass
