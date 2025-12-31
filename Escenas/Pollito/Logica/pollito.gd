extends CharacterBody2D

enum ANIM_STATE {JUMPING, GROUNDING, FLYING, FREZZE}
var cur_anim_state = ANIM_STATE.JUMPING

enum STATE { JUMPING, GROUND, FLY, AUTO }
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
var move_anim : float

@onready var objectInteraction = $ObjectsInteraction
var is_moving = false

func _ready():
	if cur_state == STATE.AUTO:
		add_to_group("weight_box")
	add_to_group("player")

func _physics_process(_delta: float) -> void:
	var move = Input.get_axis('ui_left', 'ui_right')
	move_anim = move
	if move != 0.0: direction = move
	
	if cur_state != STATE.AUTO:
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
			
			cur_anim_state = ANIM_STATE.GROUNDING
		STATE.JUMPING:
			velocity.y += gravity_fall if velocity.y > 0.0 else gravity_jump
			
			if can_impulse_jump and Input.is_action_pressed('ui_accept') and velocity.y < 0.0:
				velocity.y -= jump_impulse
			elif Input.is_action_just_released('ui_accept'):
				can_impulse_jump = false
			
			if Input.is_action_just_pressed('ui_accept'):
				velocity.y = -fly_force
				cur_state = STATE.FLY
			
			cur_anim_state = ANIM_STATE.JUMPING
		STATE.FLY:
			velocity.y += gravity_fly
			if Input.is_action_just_pressed('ui_accept'):
				velocity.y = -fly_force
			
			cur_anim_state = ANIM_STATE.JUMPING
		STATE.AUTO:
			if not is_on_floor():
				velocity.y += gravity_fall
			if not is_moving : move = 0.0
			is_moving = false
			
	
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
		ANIM_STATE.FLYING:
			pass
		ANIM_STATE.GROUNDING:
			if move_anim == 0.0:
				$AnimatedSprite2D.play("idle")
			else:
				$AnimatedSprite2D.play("walk")

func push_move(mov : float) -> void:
	is_moving = true
	velocity.x = -mov * (1.0 / objectInteraction.weight) * objectInteraction.softness

func interaction(_object):
	objectInteraction.interaction(_object)

func get_weight() -> float:
	return objectInteraction.weight

func snap_floor_position(position_y, _height) -> void:
	if is_on_floor():
		position.y = position_y - 15.0
