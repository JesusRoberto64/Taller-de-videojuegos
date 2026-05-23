extends CharacterBody2D

enum STATE { NORMAL, DASH }
var cur_state = STATE.NORMAL

var direction = 1.0
var jump_force = 500.0
var gravity = 30.0
var speed = 130.0

var is_runnig = false
var runnig_timer = 0.0
var runnig_timer_limit = 0.25
var waiting_second_tab = false

var dash_force = 950.0

var timer = 0.0
var timer_limit = 0.4

func _physics_process(delta):
	var move = Input.get_axis("ui_left", "ui_right")
	direction = move if move != 0.0 else direction
	
	match cur_state:
		STATE.NORMAL:
			var move_speed = speed
			runnig_timer -= delta
			if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
				if waiting_second_tab and runnig_timer > 0.0:
					is_runnig = true
				else:
					waiting_second_tab = true
					runnig_timer = runnig_timer_limit
			
			if move == 0.0:
				is_runnig = false
			elif is_runnig:
				move_speed *= 1.5
			
			velocity.x = move * move_speed
			velocity.y += gravity
			if Input.is_action_just_pressed("ui_accept") and is_on_floor():
				velocity.y = -jump_force
			
			move_and_slide()
			
			if Input.is_action_just_pressed("Dash"):
				cur_state = STATE.DASH
				velocity.x = dash_force * direction
		STATE.DASH:
			velocity.y += gravity
			velocity.x = lerp(velocity.x, 0.0, delta * 7.0)
			move_and_slide()
			
			timer -= delta
			if timer <= 0.0:
				timer = timer_limit
				cur_state = STATE.NORMAL
				velocity.x = 0.0
