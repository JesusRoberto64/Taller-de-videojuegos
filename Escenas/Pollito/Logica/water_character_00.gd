extends CharacterBody2D

var gravity = 18.0
@onready var objectInteraction = $water_bodyInteraction

func _physics_process(delta: float) -> void:
	velocity.y += gravity

func interaction(_object):
	objectInteraction.interaction(_object)

func get_weight() -> float:
	return objectInteraction.weight

func snap_floor_position(position_y, _height) -> void:
	position.y = position_y - 13.0
	pass
