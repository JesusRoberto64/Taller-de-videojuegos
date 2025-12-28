extends CharacterBody2D

var gravity = 15.0

@onready var objectInteraction = $ObjectsInteraction
var is_moving = false

func _ready():
	add_to_group("weight_box")

func _physics_process(_delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity
	if not is_moving : velocity.x = 0.0
	is_moving = false
	move_and_slide()

func push_move(mov : float) -> void:
	is_moving = true
	velocity.x = -mov * (1.0 / objectInteraction.weight) * objectInteraction.softness

func interaction(_object):
	objectInteraction.interaction(_object)

func get_weight() -> float:
	return objectInteraction.weight

func set_floor_position(position_y, _gravity : float = 10.0, _direction : float = 1.0) -> void :
	if is_on_floor():
		position.y = position_y - 13.0
