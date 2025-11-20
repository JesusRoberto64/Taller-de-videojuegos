extends Camera2D

var target_node = self

var x : float = 320.0
var y : float = 180.0
var min_x : float = 0.0
var max_x : float = x
var min_y : float = 0.0
var max_y : float = y

func _process(_delta: float) -> void:
	cam_postion()

func cam_postion() -> void:
	var target : Vector2 = target_node.position
	if target.x > max_x:
		max_x += x
		min_x += x
	elif target.x < min_x:
		max_x -= x
		min_x -= x
	position.x = lerpf(position.x, min_x, 0.1)
	
	if target.y > max_y:
		max_y += y
		min_y += y
	elif target.y < min_y:
		max_y -= y
		min_y -= y
	position.y = lerpf(position.y, min_y, 0.1)

func set_target(_node):
	target_node = _node
