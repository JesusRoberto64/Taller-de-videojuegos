# Collectaton Data
extends Node

var Door = null
var Weapon : int = 0
var position = null

func set_door_position(_door : Variant, _postion: Vector2) -> void:
	if _door == Door:
		position = _postion
