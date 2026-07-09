extends Area2D

var is_opened = false

var ITEMS : Dictionary = {
	"watermelon" : preload("res://Escenas/Colectaton/sandia.tscn"),
	"hoja": preload("res://Escenas/Colectaton/hoja.tscn")
}
@export var select_items : Dictionary[String, PackedInt32Array] 

func drop_items():
	for item in select_items:
		for p in randi_range(select_items[item][0], select_items[item][1]):
			var inst = ITEMS[item].instantiate()
			var randnum = randf_range(-35.0, 35.0)
			inst.position += Vector2(randnum, -35.0)
			add_child(inst)

func _on_body_entered(body):
	if not is_opened:
		$Sprite2D.frame += 1
		is_opened = true
		call_deferred("drop_items")
