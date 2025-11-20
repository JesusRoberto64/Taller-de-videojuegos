extends Player_Collectaton

var gravity_jump = 10.0
var gravity_down = 15.0
var jump_force = 300.0

func _physics_process(_delta: float) -> void:
	var mov = Input.get_axis('ui_left', 'ui_right')
	vec_anim.x = mov 
	direction.x = mov if mov != 0.0 else direction.x 
	
	if is_on_floor():
		velocity.y = 0.0
		if Input.is_action_just_pressed('ui_accept'):
			velocity.y = -jump_force
	else:
		velocity.y += gravity_down if velocity.y > 0.0 else gravity_jump
	
	velocity.x = mov * speed
	move_and_slide()

func _process(_delta: float) -> void:
	$AnimatedSprite2D.flip_h = false if direction.x > 0.0 else true
	if vec_anim.x == 0.0:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("walk")
