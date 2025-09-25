extends Node2D

var hojas : int = 0
@onready var hojas_lab = $CanvasLayer/Hojas_lab

# Conexiones
@onready var Player : CharacterBody2D = $Ysort/Player

func _ready() -> void:
	#HUB
	Player.area.area_entered.connect(get_hoja)

func get_hoja(body: Node2D) -> void:
	body.taked()
	hojas += 1
	hojas_lab.text = "X " + str(hojas)
