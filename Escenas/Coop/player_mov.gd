extends CharacterBody2D

enum PLAYERS {P1, P2}
@export var player = PLAYERS.P1 
var player_input = "p1_"

@onready var anim = $AnimatedSprite2D
@onready var ancher = $ancher

var speed = 50.0
var direction : Vector2 = Vector2.DOWN
var mov_anim

var radian : float = 0.0

func _ready() -> void:
	if player == PLAYERS.P2:
		player_input = "p2_"
	pass

func _physics_process(delta: float) -> void:
	var mov = Input.get_vector( player_input +'left',  player_input +'right',  player_input +'up',  player_input +'down')
	mov_anim = mov
	velocity = mov * speed
	
	var target_direction = atan2(direction.y, direction.x)
	ancher.rotation = lerp_angle(ancher.rotation, target_direction, delta* 15.0) 
	
	move_and_slide()

func _process(_delta: float) -> void:
	var anim_type : String
	if mov_anim == Vector2.ZERO:
		anim_type = "idle"
	else:
		direction = mov_anim
		anim_type = "walk"
		if mov_anim.x != 0.0:
			anim.flip_h = false if mov_anim.x < 0.0 else true
	
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
