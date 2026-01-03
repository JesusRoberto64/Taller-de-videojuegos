extends CharacterBody2D

enum STATE { JUMPING, GROUND, FLY, FREEZE}
@export var cur_state = STATE.JUMPING

var jump_force = 225.0
var jump_impulse = 5.0
var can_impulse_jump = false

var fly_force = 100.0
var gravity_fall = 15.0
var gravity_jump = 12.0
var gravity_fly = 10.0

var speed = 50.0
var direction = 1.0

func _physics_process(_delta: float) -> void:
	var move = Input.get_axis('ui_left', 'ui_right')
	if move != 0.0: direction = move
	
	if is_on_floor():
		cur_state = STATE.GROUND
	elif cur_state == STATE.GROUND:
		cur_state = STATE.JUMPING
	
	match cur_state:
		STATE.GROUND:
			if Input.is_action_just_pressed('ui_accept'):
				velocity.y = -jump_force
				cur_state = STATE.JUMPING
				can_impulse_jump = true
		STATE.JUMPING:
			velocity.y += gravity_fall if velocity.y > 0.0 else gravity_jump
			
			if can_impulse_jump and Input.is_action_pressed('ui_accept') and velocity.y < 0.0:
				velocity.y -= jump_impulse
			elif Input.is_action_just_released('ui_accept'):
				can_impulse_jump = false
			
			if Input.is_action_just_pressed('ui_accept'):
				velocity.y = -fly_force
				cur_state = STATE.FLY
		STATE.FLY:
			velocity.y += gravity_fly
			if Input.is_action_just_pressed('ui_accept'):
				velocity.y = -fly_force
		STATE.FREEZE:
			velocity = Vector2.ZERO
			move = 0.0
	
	velocity.x = move * speed
	move_and_slide()
	
	if get_slide_collision_count() > 0:
		if get_last_slide_collision().get_collider().name == "Picos":
			get_tree().reload_current_scene()

func _on_finish_entered(body: Node2D) -> void:
	if body.name == "Chiki":
		cur_state = STATE.FREEZE
