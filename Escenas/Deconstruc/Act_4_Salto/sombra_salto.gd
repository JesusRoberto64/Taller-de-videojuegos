extends Sprite2D

@export var jumper : AnimatedSprite2D = null
var init_pos_y = 0.0

func _ready() -> void:
	if jumper != null:
		init_pos_y = jumper.position.y

func _process(delta: float) -> void:
	if jumper == null: return
	var cur_pos = (init_pos_y - jumper.position.y) * 0.5
	scale = Vector2(1.0, 1.0) * max(0.15, (1.0 - (min(cur_pos, 100.0)*0.01)))
	
	# Expandir sombra
	if jumper.animation == "grounded" and jumper.frame < 2:
		scale.x = 2.0
