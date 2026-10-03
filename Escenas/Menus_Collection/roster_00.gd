extends Node2D

@onready var grid = $HBoxContainer/ScrollContainer/GridContainer
@onready var show_spr = $HBoxContainer/VBoxContainer/TextureRect_Show/Show_spr 
@onready var label_info = $HBoxContainer/VBoxContainer/Panel/Label
@onready var selector = $HBoxContainer/ScrollContainer/GridContainer/TextureRect/Selector
@onready var grid_sprite = $HBoxContainer/ScrollContainer/GridContainer/TextureRect/grid_sprite 
var cur_grid : TextureRect
var last_grid : TextureRect

func _ready():
	for i in grid.get_children():
		i.set_focus_mode(2)
		i.focus_entered.connect(insert_selector)
	grid.get_children()[0].grab_focus()
	cur_grid = grid.get_children()[0]

func insert_selector():
	last_grid = cur_grid
	for i in grid.get_children():
		if i.has_focus():
			cur_grid = i
	selector.reparent(cur_grid, false)
	if cur_grid.get_child_count() > 0 and cur_grid.get_child(0) is Sprite2D:
		var spr = cur_grid.get_child(0)
		set_show_texture(spr)
		set_label_info(spr)
	else:
		show_spr.texture = null
		label_info.text = ""

func set_show_texture(spr : Sprite2D):
	show_spr.texture = spr.texture
	show_spr.hframes = spr.hframes
	show_spr.vframes = spr.vframes

func set_label_info(spr: Sprite2D):
	if spr.info != null:
		label_info.text = spr.info 
	else:
		label_info.text = ""
