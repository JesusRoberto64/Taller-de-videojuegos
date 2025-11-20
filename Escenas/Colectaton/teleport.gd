extends Area2D

@export var pair : Area2D = null
var is_open = true

func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)

func on_body_entered(body : Node2D):
	if is_open and pair != null:
		pair.is_open = false
		body.global_position = pair.global_position

func on_body_exited(_body : Node2D):
	is_open = true
