extends Node2D

@onready var Hojas = $Hojas
@onready var hojas_lab = $CanvasLayer/Hojas_lab
var hojas_counter : int = 0

func _ready() -> void:
	for h in Hojas.get_children():
		h.connect("body_entered", add_hojas)

func add_hojas(_body : Node2D) -> void:
	hojas_counter += 1
	hojas_lab.text = 'X' + str(hojas_counter)
