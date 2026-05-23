# Overlord
extends Node2D

@onready var character = $TopView_character

func _ready():
	var d = CollectatonData.Door
	var doors = get_tree().get_nodes_in_group("Door")
	if d == null:
		character.global_position = doors[0].global_position
	else:
		for i in doors.size():
			if doors[i].my_door == d:
				character.global_position = doors[i].global_position
