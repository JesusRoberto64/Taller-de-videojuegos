extends Camera2D

var last_pos: Vector2 = Vector2.ZERO
var moving := false

func _ready() -> void:
	drag_horizontal_enabled = true
	drag_vertical_enabled = true

func offset_adjust(mov: Vector2)-> void:
	var screen_pos = get_screen_center_position()
	
	if mov == Vector2.ZERO and last_pos.distance_to(screen_pos) <= 0.05 :
		reset_smoothing()
	
	if last_pos != screen_pos:
		drag_horizontal_offset = mov.x
		drag_vertical_offset = mov.y
		last_pos = screen_pos
