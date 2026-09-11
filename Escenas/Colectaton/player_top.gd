class_name Player_Collectaton
extends CharacterBody2D

var speed  : float = 100.0
var direction : Vector2 = Vector2.RIGHT
var vec_anim : Vector2 = Vector2.ZERO

@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	call_deferred("set_init_postion")

func _physics_process(_delta: float) -> void:
	var mov = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
	vec_anim = mov
	if mov != Vector2.ZERO: direction = mov
	velocity = mov * speed
	move_and_slide()

func _process(_delta: float) -> void:
	anim.flip_h = false if direction.x > 0.0 else true
	
	
	var anim_type = "back"
	if direction.y >= 0.0:
		anim_type = "front"
	  
	if vec_anim == Vector2.ZERO:
		anim.play(anim_type + "_idle")
	else:
		anim.play(anim_type + "_walk")

func set_init_postion() -> void:
	if CollectatonData.Door != null:
		global_position = CollectatonData.position
