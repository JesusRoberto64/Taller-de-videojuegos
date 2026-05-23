# Door
extends Marker2D

@export_enum("A", "B", "C") var my_door

func _ready():
	add_to_group("Door")
