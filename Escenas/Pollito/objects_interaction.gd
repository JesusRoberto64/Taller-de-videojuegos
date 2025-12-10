extends Node

var collider = null
var collision_normal : Vector2 = Vector2.ZERO
var player : CharacterBody2D = null

func _ready() -> void:
	player = get_parent()

func _physics_process(delta: float) -> void:
	var collision = player.get_last_slide_collision()
	if collision != null:
		collider = collision.get_collider()
		collision_normal = collision.get_normal()
		interaction(delta)

func interaction(delta):
	match collider.name:
		"Balance":
			if collision_normal.y < 0.0:
				collider.get_parent().interaction(delta)
			pass
