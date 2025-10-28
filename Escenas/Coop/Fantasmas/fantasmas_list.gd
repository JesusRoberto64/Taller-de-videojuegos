extends Node

var antonio = preload("res://Escenas/Coop/Fantasmas/fantasma_Antonio.tscn")
var camila = preload("res://Escenas/Coop/Fantasmas/fantasma_Camila.tscn")
var carlos = preload("res://Escenas/Coop/Fantasmas/fantasma_Carlos.tscn")
var espectro = preload("res://Escenas/Coop/Fantasmas/fantasma_Espectro.tscn")
var hector = preload("res://Escenas/Coop/Fantasmas/fantasma_Hector.tscn")
var julio = preload("res://Escenas/Coop/Fantasmas/fantasma_Juilio.tscn")
var sofiaA = preload("res://Escenas/Coop/Fantasmas/fantasma_SofiA.tscn")
var sofiaS = preload("res://Escenas/Coop/Fantasmas/fantasma_SofiS.tscn")
var socrates = preload("res://Escenas/Coop/Fantasmas/fantasma_Socrates.tscn")

var list : Array = []
var invoked : Array = []
signal no_ghost

var fernando = preload("res://Escenas/Coop/Fantasmas/fantasma_Fernando.tscn")

func _ready() -> void:
	list =[
		antonio, 
		camila,
		carlos,
		espectro,
		hector,
		julio,
		sofiaA,
		sofiaS,
		socrates
	]

func invoke(father, level: int = 1, speed_mult : int = 1) -> void:
	invoked = []
	var fantasma : Fantasma 
	if level % 7 == 0:
		fantasma = fernando.instantiate()
	else:
		fantasma = list.pick_random().instantiate()
	fantasma.speed *= speed_mult
	father.add_child(fantasma)
	fantasma.destroyed.connect(destroyed)
	invoked.append(fantasma)

func destroyed(fantasma: Fantasma) -> void:
	invoked.erase(fantasma)
	no_ghost.emit()

func invoke_boss(father, _level: int = 1) -> void:
	invoked = []
	var fantasma : Fantasma = fernando.instantiate()#list.pick_random().instantiate()
	father.add_child(fantasma)
	fantasma.destroyed.connect(destroyed)
	invoked.append(fantasma)
