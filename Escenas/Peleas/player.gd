extends CharacterBody2D

@onready var anim_spr : AnimatedSprite2D = $AnimatedSprite2D
var anim_mov := Vector2.ZERO # Vector para animación
var direction = Vector2(1.0, 0.0)
var is_stoped = false
var speed = 150.0

# Ataques 
var hit_particle = preload("res://Escenas/Peleas/golpe.tscn")
@onready var upercut_box = $Hitboxes/UpercutShape
@onready var punch_box = $Hitboxes/PunchShape
@onready var kick_box = $Hitboxes/KickShape
@onready var hit_pos = $Hitboxes/hitpos
@onready var hit_boxes = $Hitboxes
var is_attacking = false
var combo_buffer = false
var combo = 0

var hit_loop_timer = 0.0
var hit_loop_counter = 0.0 # Timer for interval
var hit_loop_interval : int = 0

func _physics_process(delta: float) -> void:
	var mov = Input.get_vector("Izquerda", "Derecha", "Arriba", "Abajo")
	anim_mov = mov
	# Poner direccion
	if mov.x != 0.0 and !is_attacking:
		direction.x = roundf(mov.x)
		anim_spr.scale.x = -direction.x
		hit_boxes.scale.x = -direction.x
	
	var trigger_attack = Input.is_action_just_pressed("punch")
	
	if is_attacking:
		mov = Vector2.ZERO
		if combo < 4:
			attack_loop(delta, trigger_attack)
		elif !combo_buffer:
			anim_spr.play("hit_kick")
			kick_box.disabled = false
			combo_buffer = true
	
	# Golpe
	if trigger_attack and !is_attacking:
		is_attacking = true
		#punch_box.disabled = false
		anim_spr.play("hit_punch") # Empezar cadena
	
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

func attack_loop(delta , trigger_attack)-> void:
	var anim = anim_spr.get_animation()
	hit_loop_timer += delta
	if trigger_attack and hit_loop_timer < 0.25:
		hit_loop_timer = 0.0
		if anim == "hit_punch" or anim == "hit_punch_loop":
			anim_spr.play("hit_punch_loop")
	elif hit_loop_timer >= 0.25:
		anim_spr.play("hit_punch")
		var current_frame = anim_spr.get_frame()
		var current_progress = anim_spr.sprite_frames.get_frame_count("hit_punch")
		anim_spr.set_frame_and_progress(current_frame, current_progress)
		hit_loop_interval = 0
		combo = 0
	
	hit_loop_counter += delta
	if hit_loop_counter > 0.1:
		hit_loop_counter = 0.0
		hit_loop_interval += 1
		if hit_loop_interval % 2 == 0:
			punch_box.disabled = false
		else:
			punch_box.disabled = true

func _on_punch_body_entered(_body: Node2D) -> void:
	var particle = hit_particle.instantiate()
	particle.position = hit_pos.position
	add_child(particle)
	print(anim_spr.get_animation())
	combo += 1

func _on_animation_finished() -> void:
	var prefix = anim_spr.get_animation().get_slice("_", 0)
	
	if combo_buffer:
		match anim_spr.get_animation():
			"hit_kick":
				anim_spr.play("hit_upercut")
				kick_box.disabled = false
				punch_box.disabled = true
			"hit_upercut":
				anim_spr.play("hit_kick")
				upercut_box.disabled = false
				kick_box.disabled = true
				combo_buffer = false
				combo = 0
		return
	
	if prefix == "hit":
		is_attacking = false
		
		punch_box.disabled = true
		upercut_box.disabled = true
		kick_box.disabled = true
		
		anim_spr.play("idle")
		hit_loop_timer = 0.0
		combo_buffer = false
		
