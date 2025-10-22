extends Node2D

var almas : int = 0
var players : Array = []

func _ready() -> void:
	players = get_tree().get_nodes_in_group("Player")
	for player in players:
		player.connect("get_alma", get_alma)

func _process(_delta: float) -> void:
	pass

func get_alma() -> void:
	almas += 1
	pass
