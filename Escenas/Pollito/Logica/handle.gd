extends AnimatableBody2D

var move = false
var is_rotating = false
var step = 0.0
var radian = 0.0

func _ready() -> void:
	add_to_group("handle")

func _physics_process(delta: float) -> void:
	rotation = radian
	if move:
		radian = lerp(radian, step, delta * 5.0)
		if abs(radian - step) < 0.05:
			radian = step
			move = false

func move_handle(direction: Vector2) -> void:
	if move: return
	move = true
	var dir = 0.0
	var step_dir : Vector2 = Vector2(-roundf(sin(step)) , roundf(cos(step)))
	
	match step_dir:
		Vector2.DOWN:
			dir = sign(direction.x)
		Vector2.RIGHT:
			dir = sign(direction.y) * -1.0
		Vector2.UP:
			dir = sign(direction.x) * -1.0
		Vector2.LEFT:
			dir = sign(direction.y) 
	
	step += (PI / 2.0) * dir
