extends Node2D

@export var to_level : PackedScene = null

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_packed(to_level)
