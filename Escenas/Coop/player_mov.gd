extends CharacterBody2D

enum PLAYERS {P1, P2}
@export var player = PLAYERS.P1 
var player_input = "p1_"

@onready var anim = $AnimatedSprite2D
@onready var area = $CollisionShape2D
@onready var ancher = $ancher
@onready var light_shape = $ancher/CollisionPolygon2D

var direction : Vector2 = Vector2.DOWN
var speed = 95.0

var mov_anim

var radian : float = 0.0
var is_holding : bool = false
var holding_dir : Vector2 = Vector2.LEFT

var scared = false
var recovering = false
var recover_frames : int = 0
var recover_timer : float = 0.0

func _ready() -> void:
	if player == PLAYERS.P2:
		player_input = "p2_"
		var animation = load("res://Escenas/Coop/player_2_animation.tres")
		anim.sprite_frames = animation

func _physics_process(delta: float) -> void:
	if scared : return
	
	var mov = Input.get_vector( player_input +'left',  player_input +'right',  player_input +'up',  player_input +'down')
	mov_anim = mov
	
	is_holding = false
	if Input.is_action_pressed(player_input + 'hold'):
		is_holding = true
	else:
		direction = mov if mov != Vector2.ZERO else direction
		var target_direction = atan2(direction.y, direction.x)
		ancher.rotation = lerp_angle(ancher.rotation, target_direction, delta* 10.0) 
	
	velocity = mov * speed
	move_and_slide()
	
	position.x = clamp(position.x, 12.0, 308.0)
	position.y = clamp(position.y, 12.0, 168.0)
	
	if recovering:
		recover_timer += delta
		if recover_timer >= 1.0:
			recover_timer = 0.0
			recover_frames = 0
			recovering = false
			anim.show()

func _process(_delta: float) -> void:
	if scared : return
	
	if recovering:
		recover_frames += 1
		if recover_frames % 4 == 0:
			anim.hide()
		elif recover_frames % 7 == 0:
			anim.show()
	
	var anim_type : String
	var anim_dir = direction
	
	if mov_anim == Vector2.ZERO:
		anim_type = "idle"
	else:
		anim_type = "walk"
	
	if is_holding:
		holding_dir = Vector2(snappedf(cos(ancher.rotation), 0.1), snappedf(sin(ancher.rotation),0.1))
		anim_dir = holding_dir
	
	anim.flip_h = false if anim_dir.x < 0.0 else true
	
	match anim_dir:
		Vector2.DOWN:
			anim.play(anim_type + "_front")
		Vector2.UP:
			anim.play(anim_type + "_back")
		Vector2.LEFT, Vector2.RIGHT:
			anim.play(anim_type + "_side")
		_:
			if anim_dir.dot(Vector2.UP) > 0.0:
				anim.play(anim_type + "_backDiagonal")
			elif anim_dir.dot(Vector2.UP) < 0.0:
				anim.play(anim_type + "_frontDiagonal")

func _on_area_entered(_area: Area2D) -> void:
	if recovering : return
	recovering = true
	
	ancher.hide()
	light_shape.call_deferred("set_disabled", true)
	$Timer.start()
	anim.play("scream")
	scared = true

func _on_timer_timeout() -> void:
	ancher.show()
	light_shape.call_deferred("set_disabled", false)
	scared = false
