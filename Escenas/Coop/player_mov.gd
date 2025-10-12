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

func _ready() -> void:
	if player == PLAYERS.P2:
		player_input = "p2_"
	pass

func _physics_process(delta: float) -> void:
	var mov = Input.get_vector( player_input +'left',  player_input +'right',  player_input +'up',  player_input +'down')
	direction = mov if mov != Vector2.ZERO else direction
	mov_anim = mov
	
	velocity = mov * speed
	
	is_holding = false
	if Input.is_action_pressed(player_input + 'hold'):
		is_holding = true
	
	if !is_holding:
		var target_direction = atan2(direction.y, direction.x)
		ancher.rotation = lerp_angle(ancher.rotation, target_direction, delta* 10.0) 
	
	move_and_slide()
	
	position.x = clamp(position.x, 12.0, 308.0)
	position.y = clamp(position.y, 12.0, 168.0)

func _process(_delta: float) -> void:
	var anim_type : String
	
	if mov_anim == Vector2.ZERO:
		anim_type = "idle"
	else:
		anim_type = "walk"
	
	
	if is_holding:
		var str_anim = anim.get_animation().get_slice("_", 1)
		anim.play(anim_type + "_" + str_anim)
		return
	
	anim.flip_h = false if direction.x < 0.0 else true
	
	match direction:
		Vector2.DOWN:
			anim.play(anim_type + "_front")
		Vector2.UP:
			anim.play(anim_type + "_back")
		Vector2.LEFT, Vector2.RIGHT:
			anim.play(anim_type + "_side")
		_:
			if direction.dot(Vector2.UP) > 0.0:
				anim.play(anim_type + "_backDiagonal")
			elif direction.dot(Vector2.UP) < 0.0:
				anim.play(anim_type + "_frontDiagonal")

func _on_area_entered(_area: Area2D) -> void:
	ancher.hide()
	light_shape.call_deferred("set_disabled", true)
	$Timer.start()

func _on_timer_timeout() -> void:
	ancher.show()
	light_shape.call_deferred("set_disabled", false)
