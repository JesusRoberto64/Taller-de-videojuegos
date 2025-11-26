extends CharacterBody2D

enum ANIM_STATE {JUMPING, GROUNDING}
var cur_anim_state = ANIM_STATE.GROUNDING

var jump_force = 70.0 #100.0
var jump_counter : int = 2
var jump_mult = 3.0
var gravity = 10.0

var speed = 50.0
var direction = 1.0
var move_anim : float

func _physics_process(_delta: float) -> void:
	var move = Input.get_axis('ui_left', 'ui_right')
	move_anim = move
	if move != 0.0: direction = move
	
	if is_on_floor():
		cur_anim_state = ANIM_STATE.GROUNDING
		jump_counter = 2
		jump_mult = jump_counter
		velocity.y = 0.0
	else:
		cur_anim_state = ANIM_STATE.JUMPING
		velocity.y += gravity
	
	if Input.is_action_just_pressed('ui_accept') and jump_counter > 0:
		velocity.y = -jump_force * jump_mult
		jump_counter -= 1
		jump_mult = jump_counter + 1
	
	velocity.x = move * speed
	move_and_slide()

func _process(_delta: float) -> void:
	if direction > 0.0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
	
	match cur_anim_state:
		ANIM_STATE.JUMPING:
			if velocity.y > 0.0:
				$AnimatedSprite2D.play("fall")
			else:
				$AnimatedSprite2D.play("jump")
		ANIM_STATE.GROUNDING:
			if move_anim == 0.0:
				$AnimatedSprite2D.play("idle")
			else:
				$AnimatedSprite2D.play("walk")
