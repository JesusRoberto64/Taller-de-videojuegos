extends Node2D

var flush = preload("res://Escenas/Pollito/water_character_00.tscn")
@onready var mark = $Marker2D

func _ready() -> void:
	$Faucet.click.connect(click)

func click() -> void:
	var f = flush.instantiate()
	f.position = mark.position
	add_child(f)
