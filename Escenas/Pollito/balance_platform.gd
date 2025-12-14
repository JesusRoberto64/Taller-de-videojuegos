extends AnimatableBody2D

var balance
var bodies : Array = []

func _ready() -> void:
	balance = get_parent()
	add_to_group("balance_platform")

func _physics_process(delta):
	var collision = move_and_collide(Vector2.UP, true)
	if collision != null:
		var collider = collision.get_collider()
		if  collider.is_in_group("weight_body"):
			balance.counter_weight(bodies, delta)
	else:
		bodies.clear()

func set_weight(body):
	if !bodies.has(body):
		bodies.append(body)

func quit_weight(body):
	if bodies.has(body):
		bodies.erase(body)
	
