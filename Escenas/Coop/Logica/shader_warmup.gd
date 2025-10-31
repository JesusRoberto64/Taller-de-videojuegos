extends Node

var shaders = [
	preload("res://Escenas/Coop/Recursos/fantasma_glow.gdshader"),
	preload("res://Escenas/Coop/Recursos/light_2d.gdshader"),
	preload("res://Escenas/Coop/Recursos/vinnete.gdshader")
]

var particles = [
	preload("res://Escenas/Coop/Escenas/particles_apearing.tscn")
]

var run = true

func _process(_delta: float) -> void:
	if not run: return
	for mat in shaders:
		var s = Sprite2D.new()
		s.material = mat
		add_child(s)
	
	for par in particles:
		var p = par.instantiate()
		add_child(p)
		p.emitting = true
	run = false

func _on_timer_timeout() -> void:
	for p in get_children():
		if p is GPUParticles2D:
			p.emitting = false
