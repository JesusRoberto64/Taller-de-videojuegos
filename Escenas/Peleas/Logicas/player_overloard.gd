extends CharacterBody2D

enum STATE {READY, MOVE, PUNCHING, HURT}
var cur_state = STATE.READY

# Logics
@onready var States = $Logic/States
@onready var Movement = $Logic/Movement
@onready var Punches = $Logic/Punches
@onready var Damage = $Logic/Damage

@export var maxHp = 100.0
var hp = maxHp

func _ready() -> void:
	Movement.set_overlord(self)

func _physics_process(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	pass

func set_damage():
	pass

func get_damage():
	pass
