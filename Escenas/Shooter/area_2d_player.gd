extends Area2D

func get_ring() -> void:
	owner.MAX_ACCEL *= 1.15
	owner.MAX_ACCEL = min(owner.MAX_ACCEL, 300.0)
