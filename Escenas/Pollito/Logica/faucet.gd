extends AnimatableBody2D

var max_radian = PI / 4.0
var radian = 0.0

var is_pushing = false
var is_click = false

signal click

func _ready() -> void:
	add_to_group("faucet")

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(Vector2.UP * 5.0, true)
	if collision != null:
		var collider = collision.get_collider()
		if collider.is_in_group("weight_body")and collision.get_normal().y > 0.0:
			is_pushing = true
	
	if is_pushing:
		radian = lerpf(radian, 0.0, delta * 10.0) 
		if radian <= 0.025:
			radian = 0.0
			is_pushing = false
			clicker()
	else:
		radian = lerpf(radian, max_radian, delta * 5.0) 
		if abs(radian - max_radian) <= 0.1:
			radian = max_radian
			is_click = false
	
	
	is_pushing = false
	rotation = radian

func clicker() -> void:
	if not is_click:
		is_click = true
		click.emit()
		print("clik", randi())
