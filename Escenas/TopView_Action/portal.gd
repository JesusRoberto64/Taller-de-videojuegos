# Portal
extends Area2D

@export var to_level : String
@export_enum("A", "B", "C") var my_door
var is_trasport = false

func _ready():
	body_entered.connect(on_body_entered)

func _process(delta):
	if is_trasport and to_level != null and my_door != null:
		CollectatonData.Door = my_door
		get_tree().change_scene_to_file(to_level)

func on_body_entered(_body: Node2D) -> void:
	is_trasport =  true
