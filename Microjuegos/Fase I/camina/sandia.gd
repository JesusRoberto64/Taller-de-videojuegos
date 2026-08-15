extends Area2D

var gravity_fall = 80.0
var is_eated = false
signal on_eated

func _process(delta):
	if is_eated: 
		on_eated.emit()
		queue_free()
	
	rotation += delta * 3.0
	position.y += gravity_fall * delta
	
	if position.y > 200.0:
		queue_free()

func _on_body_entered(_body):
	is_eated = true
