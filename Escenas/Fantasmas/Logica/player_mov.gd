extends CharacterBody2D

enum PLAYERS {P1, P2}
@export var player = PLAYERS.P1 
var player_input = "p1_"

@onready var anim = $AnimatedSprite2D
@onready var area = $CollisionShape2D
@onready var ancher = $ancher
@onready var light_shape = $ancher/CollisionPolygon2D
# SFX
@onready var alma_sfx = $alma_sfx
@onready var scream_sfx = $scream_sfx
@onready var recover_sfx = $recover_sfx

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

signal get_alma
@onready var anim_player = $AnimationPlayer

var friend = null
var is_celebration = false
var is_loose = false

func _ready() -> void:
	if player == PLAYERS.P2:
		player_input = "p2_"
		var animation = load("res://Escenas/Fantasmas/Recursos/player_2_animation.tres")
		anim.sprite_frames = animation
	# To add power
	get_alma.connect(_on_get_alma)
	ancher.scale = Vector2(0.5,0.5)
	
	var players = get_tree().get_nodes_in_group("Player")
	for f in players:
		if f != self:
			friend = f
			break


func _physics_process(delta: float) -> void:
	if scared or is_celebration or is_loose: return
	
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
	position.y = clamp(position.y, 6.0, 168.0)
	
	if recovering:
		recover_timer += delta
		if recover_timer >= 1.0:
			recover_timer = 0.0
			recover_frames = 0
			recovering = false
			anim.show()

func _process(_delta: float) -> void:
	if is_celebration or is_loose: 
		return
	elif scared and friend != null: 
		if position.distance_to(friend.position) < 14.0:
			_on_timer_timeout()
			pass
		return
	
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
	#$Timer.start()
	anim.play("scream")
	scream_sfx.play()
	scared = true
	ancher.scale = Vector2(0.5, 0.5)

func _on_timer_timeout() -> void:
	ancher.show()
	light_shape.call_deferred("set_disabled", false)
	scared = false
	recover_sfx.play()

func _on_get_alma() -> void:
	var mult_scale = ancher.scale.x + 0.5
	mult_scale = clamp(mult_scale, 0.5, 1.5)
	ancher.scale = Vector2(mult_scale, mult_scale)
	anim_player.play("binking")
	alma_sfx.play()


func celebration() -> void:
	is_celebration = true
	anim.play("celebration")
	ancher.hide()

func loose() -> void:
	is_loose = true
	anim.play("scream")
	ancher.hide()
