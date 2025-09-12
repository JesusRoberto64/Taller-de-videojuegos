extends CharacterBody2D

var speed = 100.0
var direction = Vector2(1.0, 0.0)
var is_attacking = false
var is_stoped = false

var combo_buffer = false
var is_combo = false

@onready var punch_box = $Hitboxes/PunchShape
@onready var upercut_box = $Hitboxes/UpercutShape
@onready var kick_box = $Hitboxes/KickShape

@onready var anim_spr : AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_boxes = $Hitboxes


func _physics_process(_delta: float) -> void:
	var mov = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Poner direccion
	if mov.x != 0.0:
		direction.x = roundf(mov.x)
		anim_spr.scale.x = -direction.x
		hit_boxes.scale.x = -direction.x
	
	# Combo
	if is_attacking and is_combo:
		if Input.is_action_just_pressed("punch") and !combo_buffer:
			combo_buffer = true
	
	# Golpe
	if Input.is_action_just_pressed("punch") and !is_attacking:
		is_attacking = true
		punch_box.disabled = false
		anim_spr.play("hit_punch") # Empezar cadena
		is_stoped = true
		is_combo = true
	
	if is_stoped:
		mov = Vector2.ZERO
	
	velocity = mov * speed
	move_and_slide()
	
	# Limite de escenario sin colisiones (temporal)
	position.y = clamp(position.y, 90.0, 150.0) 

func _on_punch_body_entered(body: Node2D) -> void:
	body.queue_free()

func _on_animation_finished() -> void:
	var prefix = anim_spr.get_animation().get_slice("_", 0)
	
	if combo_buffer:
		match anim_spr.get_animation():
			"hit_punch":
				anim_spr.play("hit_upercut")
				punch_box.disabled = true
				upercut_box.disabled = false
				pass
			"hit_upercut":
				anim_spr.play("hit_kick")
				upercut_box.disabled = true
				kick_box.disabled = false
				is_combo = false
		combo_buffer = false
		return
	
	if prefix == "hit":
		is_attacking = false
		
		punch_box.disabled = true
		upercut_box.disabled = true
		kick_box.disabled = true
		
		anim_spr.play("idle")
		is_stoped = false
		is_combo = false
		combo_buffer = false
