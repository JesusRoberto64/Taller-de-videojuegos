extends Camera2D

var last_pos: Vector2 = Vector2.ZERO

@export_range(0.0, 300.0, 0.01) var speed = 30.0
@export_range(0.0, 160.0, 0.1) var max_dist : float = 30.0


func _ready() -> void:
	#drag_horizontal_enabled = true
	#drag_vertical_enabled = true
	pass

func offset_adjust(mov: Vector2)-> void:
	var screen_pos = get_screen_center_position()
	
	if mov == Vector2.ZERO and last_pos.distance_to(screen_pos) <= 0.05 :
		reset_smoothing()
	
	if last_pos != screen_pos:
		drag_horizontal_offset = mov.x
		drag_vertical_offset = mov.y
		last_pos = screen_pos

func offset_movement(mov: Vector2, delta) -> void:
	
	if mov.x != 0.0:
		offset.x += mov.x * speed * delta
	else:
		offset.x = lerpf(offset.x, 0.0, delta)
	
	offset.x = clamp(offset.x, -max_dist, max_dist)
	
	
	pass
