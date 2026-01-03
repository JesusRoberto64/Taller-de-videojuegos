## Platform Handle
extends AnimatableBody2D

var speed = 15.0
var start_pos_x : float

func _ready() -> void:
	start_pos_x = position.x

func move(_radian) -> void:
	position.x = start_pos_x - _radian * speed
