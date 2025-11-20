extends Area2D

@export_enum("Level1", "Level2" ) var to_level : String
var levels : Dictionary= {
	"Level1" : "res://Escenas/Colectaton/main_top.tscn",
	"Level2" : "res://Escenas/Colectaton/main_side.tscn",
}
@export_enum("A", "B", "C") var my_door

@export var open = true
var is_trasport = false

func _ready() -> void:
	body_entered.connect(on_body_entered)
	var pos = $Marker2D.global_position
	CollectatonData.set_door_position(my_door, pos)

func _process(_delta: float) -> void:
	if is_trasport and to_level != "":
		CollectatonData.Door = my_door
		get_tree().change_scene_to_file(levels[to_level])

func on_body_entered(_body: Node2D) -> void:
	if not open : return
	is_trasport =  true
