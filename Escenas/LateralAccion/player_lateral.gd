extends CharacterBody2D

var direction = Vector2.LEFT
var jump_force = 500.0
var gravity = 30.0
var speed = 130.0

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
var anim_mov = Vector2.LEFT

@onready var hitBoxes = $Hitboxes
@onready var punchHitBox = $Hitboxes/puch
var is_attacking = false

func _physics_process(_delta: float) -> void:
	var mov = Input.get_axis('ui_left','ui_right')
	
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
	
	if is_attacking and velocity.y == 0.0:
		rapid_punch(punch_pressed)
		mov = 0.0
	
	if punch_pressed and not is_attacking:
		is_attacking = true
		anim.play("hit_punch")
		punchHitBox.disabled = false
	
	anim_mov = mov
	velocity.x = mov * speed
	
	move_and_slide()

func _process(_delta: float) -> void:
	if is_attacking: return
	
	var on_ground : bool = velocity.y == 0.0
	var is_moving : bool = anim_mov != 0.0
	
	if on_ground and not is_moving:
		anim.play("idle")
	elif on_ground and is_moving:
		anim.play('walk')
	elif velocity.y < 0.0:
		anim.play("jump")
	elif velocity.y > 0.0:
		anim.play("falling")
	

func _on_animation_finished() -> void:
	var prefix = anim.get_animation().get_slice("_", 0)
	
	if prefix == "hit":
		punchHitBox.disabled = true
		is_attacking = false

func rapid_punch(puch_pressed) -> void:
	punchHitBox.disabled = true
	if puch_pressed:
		anim.play("hit_punch")
		anim.frame = 2
		punchHitBox.disabled = false

func _on_hitboxes_body_entered(body: Node2D) -> void:
	body.hit_anim()
