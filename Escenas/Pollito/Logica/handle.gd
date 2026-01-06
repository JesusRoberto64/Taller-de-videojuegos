## Handle
extends AnimatableBody2D

var move = false
var step = 0.0
var radian = 0.0
var direction = 0.0
@export_range(PI * 2.0, PI * 5.0,PI) var lenght = PI * 2.0

signal move_platform(_radian)

func _ready() -> void:
	add_to_group("handle")

func _physics_process(delta: float) -> void:
	var current_radian = radian
	
	rotation = radian
	
	if move:
		radian = lerp(radian, step, delta * 5.0)
		if abs(radian - step) < 0.05:
			radian = step
			move = false
		
		if radian == current_radian:
			direction = 0.0
		elif  radian > current_radian:
			direction = 1.0 # clock wise
		else:
			direction = -1.0 # conter wise
		step = clamp(step, -lenght, 0.0)
		move_platform.emit(radian)
	

func move_handle(_direction: Vector2) -> void:
	if move: return
	move = true
	var dir = 0.0
	var step_dir : Vector2 = Vector2(-roundf(sin(step)) , roundf(cos(step)))
	
	match step_dir:
		Vector2.DOWN:
			dir = sign(_direction.x)
		Vector2.RIGHT:
			dir = sign(_direction.y) * -1.0
		Vector2.UP:
			dir = sign(_direction.x) * -1.0
		Vector2.LEFT:
			dir = sign(_direction.y) 
	step += (PI / 2.0) * dir
