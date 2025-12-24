extends CharacterBody2D

enum STATE { READY, START, FREEZE, KO, NORMAL }
var cur_state = STATE.READY

var direction = Vector2.LEFT
var jump_force = 500.0
var gravity = 30.0
var speed = 130.0

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
var anim_mov = -1.0 # left

@onready var hitBoxes = $Hitboxes
@onready var punchHitBox = $Hitboxes/puch
@onready var kickHitBox = $Hitboxes/kick
var is_attacking = false

func _ready() -> void:
	# incia 
	pass

func _physics_process(_delta: float) -> void:
	var dir := Input.get_vector('ui_left', 'ui_right', 'ui_up','ui_down')
	var mov : float = dir.x
	
	match cur_state:
		STATE.READY:
			# Se inicia 3.0 2.0 1.0 0.0
			# cuando llegue a cero 
			cur_state = STATE.START
			pass
		STATE.START:
			# Animacion de inicio IM ready
			# cuando acabe la animacion
			cur_state = STATE.NORMAL
			pass
		STATE.NORMAL:
			direction.y = dir.y
			
			if mov != 0.0:
				direction.x = 1.0 if mov > 0.0 else -1.0
				anim.scale.x = -direction.x
				hitBoxes.scale. x = -direction.x
			
			if not is_on_floor():
				velocity.y += gravity
			else:
				velocity.y = 0.0
			
			if Input.is_action_just_pressed("jump") and is_on_floor():
				velocity.y = -jump_force
			
			var punch_pressed = Input.is_action_just_pressed("punch")
			
			if is_attacking:
				mov = attack_actions(anim.get_animation(), punch_pressed, mov)
			
			if punch_pressed and not is_attacking:
				is_attacking = true
				attack_animation()
			
			anim_mov = mov
			velocity.x = mov * speed
		
			move_and_slide()
			
			# ocurre que me golpean 
			#cur_state = STATE.FREEZE
			# trigger animacion hurt
			
			pass
		STATE.KO:
			pass
		STATE.FREEZE:
			# temprailador 30. 2.0 1.0
			# cur_STATE = STATE.NORAL
			
			
			pass
		_:
			pass


func _process(_delta: float) -> void:
	if is_attacking: return
	
	var on_ground : bool = velocity.y == 0.0
	var is_moving : bool = anim_mov != 0.0
	var is_crunch : bool = true if direction.y == 1.0 else false
	
	if on_ground and is_crunch:
		anim.play("crunch")
		if anim.frame > 0: 
			anim.set_frame_and_progress(1, 0.0)
	elif on_ground and not is_moving:
		anim.play("idle")
	elif on_ground and is_moving:
		anim.play('walk')
	elif velocity.y < 0.0:
		anim.play("jump")
	elif velocity.y > 0.0:
		anim.play("falling")

func attack_animation()-> void:
	if direction.y > 0.0:
		anim.play("hit_kick")
		kickHitBox.disabled = false
	else:
		anim.play("hit_punch")
		punchHitBox.disabled = false

func attack_actions(animation: String, punch_pressed: bool, mov: float) -> float:
	match animation:
		'hit_punch':
			if velocity.y == 0.0:
				punchHitBox.disabled = true
				if punch_pressed:
					anim.play("hit_punch")
					anim.frame = 2
					punchHitBox.disabled = false
				return 0.0
		'hit_kick':
			if velocity.y == 0.0:
				return 2.8 * direction.x
	return mov

func _on_animation_finished() -> void:
	var prefix = anim.get_animation().get_slice("_", 0)
	if prefix == "hit":
		punchHitBox.disabled = true
		kickHitBox.disabled = true
		is_attacking = false
	
	# fuerza bruta para terminar en animación especifica
	if anim.get_animation() == "hit_kick":
		anim.play("crunch")
		anim.set_frame_and_progress(1, 0.0)
	
func _on_hitboxes_body_entered(body: Node2D) -> void:
	body.hit_anim()
