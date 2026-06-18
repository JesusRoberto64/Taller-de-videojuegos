extends Area2D

@export var speed = 180.0 

func _physics_process(delta):
	position.x -= speed * delta
	
	if global_position.x <= -50.0:
		queue_free()

func _on_area_entered(_area):
	get_tree().call_deferred("reload_current_scene")
