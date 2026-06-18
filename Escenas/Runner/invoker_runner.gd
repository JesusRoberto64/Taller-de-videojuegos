extends Node2D

var timer = 1.0
var timer_limit = 0.5

var enemy = preload("res://Escenas/Runner/enemy_runner_00.tscn")
var marks = []

func _ready():
	marks = get_children()

func _process(delta):
	timer -= delta
	if timer <= 0.0:
		marks.shuffle()
		var cur_mark = marks[0]
		var inst = enemy.instantiate()
		cur_mark.add_child(inst)
		timer = randf_range(0.5, 3.0)
