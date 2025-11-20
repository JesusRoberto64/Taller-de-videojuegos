extends Area2D

func _ready() -> void:
	body_entered.connect(on_body_entered)
	pass

func on_body_entered(_body: Node2D):
	queue_free()
