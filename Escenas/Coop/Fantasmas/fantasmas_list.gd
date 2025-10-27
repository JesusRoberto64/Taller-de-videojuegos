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

func invoke(father, _level: int = 1) -> void:
	invoked = []
	var fantasma : Fantasma = list.pick_random().instantiate()#list.pick_random().instantiate()
	father.add_child(fantasma)
	fantasma.destroyed.connect(destroyed)
	invoked.append(fantasma)

func destroyed(fantasma: Fantasma) -> void:
	invoked.erase(fantasma)
	no_ghost.emit()
