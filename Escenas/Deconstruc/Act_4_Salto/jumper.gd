extends AnimatedSprite2D

enum STATE { IDLE, JUMP, JUMPANTI, GROUNDED, FALL }
var cur_STATE = STATE.IDLE

var velocity = Vector2.ZERO
var gravity = 1000.0
var jump_force = 200.0

var impulse_force = 0.0
var impulse_mult = 100.0

var limit_ground

func _ready() -> void:
	limit_ground = position.y

func _process(delta: float) -> void:
	var pre_velocity = velocity.y
	if position.y != limit_ground:
		velocity.y += gravity * delta 
	else:
		velocity.y = 0.0
	
	match cur_STATE:
		STATE.IDLE:
			if Input.is_action_pressed("ui_accept"):
				cur_STATE = STATE.JUMPANTI
				play("anticipation_jump")
		STATE.JUMPANTI:
			impulse_force += delta * impulse_mult
			speed_scale = min(speed_scale + delta, 3.0)
			if  Input.is_action_just_released("ui_accept"):
				velocity.y = -jump_force - impulse_force
				play("jump")
				cur_STATE = STATE.JUMP
				impulse_force = 0.0
				speed_scale = 1.0
		STATE.JUMP:
			if velocity.y > 0.0:
				play("fall")
				cur_STATE = STATE.FALL
		STATE.FALL:
			if position.y == limit_ground:
				cur_STATE = STATE.GROUNDED
				play("grounded")
				if pre_velocity < 420.0:
					frame = 2
					
		STATE.GROUNDED:
			pass
	
	position += velocity * delta
	position.y = min(limit_ground, position.y)

func _on_animation_finished() -> void:
	if animation == "grounded":
		play("idle")
		cur_STATE = STATE.IDLE
		
