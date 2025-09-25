extends CharacterBody2D

@onready var anim_spr : AnimatedSprite2D = $AnimatedSprite2D
var anim_mov := Vector2.ZERO # Vector para animación
var direction = Vector2(-1.0, 0.0)
var speed = 150.0

# Ataques 
var hit_particle = preload("res://Escenas/Peleas/golpe.tscn")
@onready var upercut_box : CollisionShape2D = $Hitboxes/UpercutShape
@onready var punch_box : CollisionShape2D= $Hitboxes/PunchShape
@onready var kick_box : CollisionShape2D= $Hitboxes/KickShape
@onready var hit_boxes : Area2D = $Hitboxes

var is_attacking = false
var combo_buffer = false
var combo_gate = false
var combo_breaker = 0
var combo = 0

var hit_loop_input_timer : float = 0.0
var hit_loop_interval_timer : float = 0.0
var hit_loop_interval : int = 0

func _physics_process(delta: float) -> void:
	var mov = Input.get_vector("Izquierda", "Derecha", "Arriba", "Abajo")
	anim_mov = mov
	# Poner direccion
	if mov.x != 0.0 and !is_attacking:
		direction.x = roundf(mov.x)
		anim_spr.scale.x = -direction.x
		hit_boxes.scale.x = -direction.x
	
	var trigger_attack = Input.is_action_just_pressed("punch")
	
	if is_attacking:
		mov = Vector2.ZERO
		if combo_breaker > 0 and combo_breaker == combo:
			combo = 7
		if not combo_buffer:
			mov.x = _process_combo_state(delta, trigger_attack)
	
	# Golpe
	if trigger_attack and !is_attacking:
		is_attacking = true
		anim_spr.play("hit_kick") # Empezar cadena
		kick_box.disabled = false
	
	velocity = mov * speed
	move_and_slide()
	
	# Limite de escenario sin colisiones (temporal)
	position.y = clamp(position.y, 90.0, 150.0)
	

func _process(_delta: float) -> void:
	if is_attacking: return
	if anim_mov == Vector2.ZERO:
		anim_spr.play("idle")
	else:
		anim_spr.play("walking")

func _process_combo_state(delta: float, trigger_attack: bool) -> float:
	if combo < 5:
		attack_loop(delta, trigger_attack)
		return 0.0
	
	match combo:
		5:
			anim_spr.play("hit_upercut")
			punch_box.disabled = true
			upercut_box.disabled = false
			#mov.x = direction.x * 5.0
			combo_buffer = true
			combo_breaker = combo
			combo_gate = true
			return direction.x * 5.0
		6:
			anim_spr.play("hit_punch")
			punch_box.disabled = false
			upercut_box.disabled = true
			#mov.x = direction.x * 12.0
			combo_buffer = true
			combo_breaker = combo
			combo_gate = true
			
			anim_spr.modulate.g = 0.0
			$CollisionShape2D.disabled = true
			return direction.x * 12.0
		_:
			anim_spr.play("hit_end")
			combo_gate = false
			combo_breaker = 0
			combo = 0
			
			anim_spr.modulate.g = 1.0
			$CollisionShape2D.disabled = false
			return 0.0

func attack_loop(delta , trigger_attack)-> void:
	var anim = anim_spr.get_animation()
	hit_loop_input_timer += delta
	if trigger_attack and hit_loop_input_timer < 0.25:
		hit_loop_input_timer = 0.0
		if anim == "hit_kick" or anim == "hit_punch_loop":
			anim_spr.play("hit_punch_loop")
			kick_box.disabled = true
	elif hit_loop_input_timer >= 0.25: # Se va el flujo
		anim_spr.play("hit_end")
		hit_loop_interval = 0
		combo = 0
	
	hit_loop_interval_timer += delta
	if anim != "hit_punch_loop":
		return
	if hit_loop_interval_timer > 0.1:
		hit_loop_interval_timer = 0.0
		hit_loop_interval += 1
		if hit_loop_interval % 2 == 0:
			punch_box.disabled = false
			
			#combo +=1 # TEST =======
			combo_gate = true
		else:
			punch_box.disabled = true

func _on_punch_body_entered(body: Node2D)-> void:
	add_puch_particle()
	
	if anim_spr.get_animation() == "hit_kick":
		body.hit_anim()
	elif anim_spr.get_animation() == "hit_upercut":
		body.hit_anim("upercut")
	elif anim_spr.get_animation() == "hit_punch":
		body.hit_anim("punch", 8)
	else:
		body.hit_anim()
	
	if combo_gate: 
		combo += 1
		combo_gate = false

func _on_animation_finished()-> void:
	var prefix = anim_spr.get_animation().get_slice("_", 0)
	
	if combo_buffer:
		combo_buffer = false
		return
	
	if prefix == "hit":
		punch_box.disabled = true
		kick_box.disabled = true
		upercut_box.disabled = true
		
		is_attacking = false
		anim_spr.play("idle")
		hit_loop_input_timer = 0.0
		combo = 0
		combo_buffer = false

func add_puch_particle()-> void:
	var particle = hit_particle.instantiate()
	particle.position.x -=  12.0
	
	for box in hit_boxes.get_children():
		if box.disabled == false:
			box.add_child(particle)
			break
