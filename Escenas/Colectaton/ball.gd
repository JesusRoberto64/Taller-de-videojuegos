extends RigidBody2D

var dir = Vector2.RIGHT
var spaw_pos = Vector2.ZERO
var is_kicked = false

func _ready() -> void:
	spaw_pos = position

func _physics_process(_delta):
	if is_kicked:
		if linear_velocity.length() < 4.0:
			physics_material_override.bounce = 0.0
			is_kicked = false

func kicked(force: Vector2) -> void:
	apply_impulse(force)
	is_kicked = true
	physics_material_override.bounce = 1.0
	pass
