extends Area2D

var is_vanish = false

func _process(_delta):
	if is_vanish:
		set_collision_mask_value(3, false)
		queue_free()

func _on_area_entered(area):
	area.get_ring()
	is_vanish = true
	#call_deferred('set_collision_layer_value', 3, false) 
	#set_collision_layer_value(3, false)
