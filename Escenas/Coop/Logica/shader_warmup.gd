extends Node

var shaders = [
	preload("res://Escenas/Coop/Recursos/fantasma_glow.gdshader"),
	preload("res://Escenas/Coop/Recursos/light_2d.gdshader"),
	preload("res://Escenas/Coop/Recursos/vinnete.gdshader")
]

var particles = [
	preload("res://Escenas/Coop/Escenas/particles_apearing.tscn")
]

func _process(_delta: float) -> void:
	for mat in shaders:
		var s = Sprite2D.new()
		s.material = mat
		add_child(s)
		s.hide()
	
	#for par in particles:
		#var p = par.instantiate()
		#add_child(p)
		#p.visible = false
		#p.emitting = true
		#await get_tree().create_timer(0.25).timeout
		#p.emitting = false
	
	queue_free()
	pass
