extends AnimatedSprite2D

func _ready() -> void:
	connect("animation_finished", on_animation_finished)

func animation_state(direction: float, direction_mov: float, 
	movement: Vector2, is_on_floor : bool, 
	velocity: Vector2, jumping : bool) -> void:
	# Movment
	if jumping and animation != 'jump':
		play("jump")
	if !is_on_floor:
		if velocity.y > 0.0:
			play("falling")
		return
	
	if movement != Vector2.ZERO:
		if direction + direction_mov == 0.0:
			play('walk')
		else:
			play('walk_back')
	else:
		play('idle')

func on_animation_finished() -> void:
	var _prefix = get_animation().get_slice("_", 0)
