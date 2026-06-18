extends Area2D

func _physics_process(_delta):
	if Input.is_action_pressed("ui_down"):
		$CollisionShape2D.disabled = true
		$CollisionShape2D2.disabled = false
	else:
		$CollisionShape2D.disabled = false
		$CollisionShape2D2.disabled = true
