extends CharacterBody2D

var speed = 160.0
var direction = 1.0
@onready var sprite = $AnimatedSprite2D
@onready var ancher_point = $ancher_point
var weapon 
var cur_weapon = 0

func _ready():
	weapon = ancher_point.get_child(cur_weapon)

func _physics_process(_delta):
	var move = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	direction = round(move.x) if move.x != 0.0 else direction
	
	sprite.flip_h = false if direction > 0.0 else true
	ancher_point.scale.x = direction
	
	velocity = move * speed
	move_and_slide()
	
	var next = 0
	if Input.is_action_just_released("switch_left"):
		next = -1
	elif Input.is_action_just_released("switch_right"):
		next = 1
	if next != 0.0:
		ancher_point.get_child(cur_weapon).set_hide()
		var size = ancher_point.get_children().size()
		cur_weapon = (cur_weapon + next + size) % size
		ancher_point.get_child(cur_weapon).set_active()
