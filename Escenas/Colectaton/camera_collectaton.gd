extends Camera2D # Movimiento Zelda

var target_node : Node2D = null
var x_size : float
var y_size : float 
var min_x : float = 0.0
var max_x : float 
var min_y : float = 0.0
var max_y : float 
var cam_speed = 5.0

func _ready():
	x_size = get_viewport_rect().size.x
	y_size = get_viewport_rect().size.y
	max_x = x_size
	max_y = y_size
	target_node = owner

func _process(delta: float) -> void:
	var target : Vector2 = target_node.position
	
	var shift_x = int(target.x > max_x) - int(target.x < min_x)
	max_x += shift_x * x_size
	min_x += shift_x * x_size
	position.x = lerpf(position.x, min_x, delta * cam_speed)
	
	var shift_y = int(target.y > max_y) - int(target.y < min_y)
	max_y += shift_y * y_size
	min_y += shift_y * y_size
	position.y = lerpf(position.y, min_y, delta * cam_speed)
