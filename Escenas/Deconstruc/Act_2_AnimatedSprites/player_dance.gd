extends AnimatedSprite2D # Player_dance

func _process(delta):
	if Input.is_action_pressed("ui_down"):
		play("dance_down")
	elif Input.is_action_pressed("ui_up"):
		play("dance_up")
	elif Input.is_action_pressed("ui_left"):
		play("dance_side")
		flip_h = true
	elif Input.is_action_pressed("ui_right"):
		play("dance_side")
		flip_h = false
	else:
		play("idle")
	
