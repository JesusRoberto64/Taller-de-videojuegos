extends Area2D

@onready var col_shape = $CollisionShape2D

func taked() -> void:
	hide()
	col_shape.call_deferred('set_disabled', true)
	
