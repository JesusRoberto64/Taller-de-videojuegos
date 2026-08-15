extends Node2D

@export var sandia : PackedScene 
var timer_limit = 1.5
var timer = timer_limit

@export var counter : Label

func _physics_process(delta):
	if timer > 0.0:
		timer -= delta
	else:
		var random_pos = randi() % 320
		var snap = round(float(random_pos)/16 - 0.5) * 16.0
		timer = timer_limit
		var inst = sandia.instantiate()
		inst.position = Vector2(snap, -16.0)
		inst.on_eated.connect(counter.add_counter)
		add_child(inst)
