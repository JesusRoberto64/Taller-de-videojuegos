extends CharacterBody2D

enum STATE {READY, MOVE, PUNCHING, HURT}
var cur_state = STATE.READY

var jumping = false
var direction = 0.0
var opponent : CharacterBody2D = null
@onready var anim = $AnimatedSprite2D
@onready var hit_boxes = $Hitboxes

# Logics
@onready var States = $Logic/States
@onready var Movement = $Logic/Movement
@onready var Punches = $Logic/Punches
@onready var Damage = $Logic/Damage

@export var maxHp = 100.0
var hp = maxHp

func _ready() -> void:
	add_to_group("Player")
	Movement.player = self
	var players = get_tree().get_nodes_in_group("Player")
	for p in players:
		if p != self:
			opponent = p

func _process(_delta: float) -> void:
	# Animation 
	anim.animation_state(direction, Movement.direction.x, 
	Movement.movement, is_on_floor(), velocity, jumping)
	
	anim.flip_h = false if direction > 0.0 else true

func _physics_process(_delta: float) -> void:
	direction = sign(position.x - opponent.position.x)
	hit_boxes.scale.x = direction
	Movement.move()

func set_damage():
	pass

func get_damage():
	pass
