class_name Player_Collectaton
extends CharacterBody2D

var speed  : float = 100.0
var direction : Vector2 = Vector2.RIGHT
var vec_anim : Vector2 = Vector2.ZERO

func _ready() -> void:
	call_deferred("set_init_postion")
	$Ancher/CameraCollectaton.set_target(self)

func _physics_process(_delta: float) -> void:
	var mov = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
	vec_anim = mov
	direction = mov if mov != Vector2.ZERO else direction
	velocity = mov * speed
	move_and_slide()

func _process(_delta: float) -> void:
	$AnimatedSprite2D.flip_h = false if direction.x > 0.0 else true
	if vec_anim == Vector2.ZERO:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("walk")

func set_init_postion() -> void:
	if CollectatonData.Door != null:
		global_position = CollectatonData.position
