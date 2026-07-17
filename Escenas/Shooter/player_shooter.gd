class_name Dolphin
extends CharacterBody2D

var speed = 20.0
var direction : float = 1.0

var MAX_ACCEL = 7.0
var drag = 215.0
var accel = Vector2.ZERO

var mov_anim : Vector2 = Vector2.ZERO

var dash_timer: float = 0.8
var is_dashing : bool = false
var BASE_ACCEL = 7.0

@onready var sprite_anim: AnimatedSprite2D = $sprite_anim
@onready var cam = $Camera2D

func _ready() -> void:
	BASE_ACCEL = MAX_ACCEL

func _physics_process(delta: float) -> void:
	var mov = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	direction = mov.x if mov.x != 0.0 else direction
	mov_anim = mov
	
	if mov != Vector2.ZERO:
		accel += mov * speed
		if accel.length() > MAX_ACCEL:
			accel = accel.normalized() * MAX_ACCEL
	else:
		accel = accel.move_toward(Vector2.ZERO, delta * drag)
	
	velocity = accel
	move_and_slide()
	
	cam.offset_movement(mov, delta)

func _process(_delta):
	sprite_anim.flip_h = true if direction < 0.0 else false
	if mov_anim != Vector2.ZERO:
		sprite_anim.speed_scale = 1.5;
	else:
		sprite_anim.speed_scale = 0.5;

func hurt():
	get_tree().reload_current_scene()


func dash(delta) -> void:
	if not is_dashing: return 
	dash_timer -= delta
	if dash_timer <= 0.0:
		MAX_ACCEL = BASE_ACCEL
		is_dashing = false
		pass
	pass
