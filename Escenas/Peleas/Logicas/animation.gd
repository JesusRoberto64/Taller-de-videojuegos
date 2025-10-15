extends AnimatedSprite2D

func _ready() -> void:
	connect("animation_finished", on_animation_finished)

func animation_state(direction: Vector2, movement: Vector2) -> void:
	# Movment
	var anim_type : String
	anim_type = "idle" if movement == Vector2.ZERO else "walk"
	
	match direction:
		_:
			pass
	
	pass

func on_animation_finished() -> void:
	var prefix = get_animation().get_slice("_", 0)
	
	pass
