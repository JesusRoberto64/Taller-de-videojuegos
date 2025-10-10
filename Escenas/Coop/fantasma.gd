extends Area2D

@export var maxHp : float = 100.0
var hp = maxHp

var is_fading = false

@onready var spr = $sprite

var light : Area2D = null

func _physics_process(delta: float) -> void:
	if is_fading:
		hp -= delta * 25.0
		hp = max(hp, 0.0)
		spr.modulate.a = hp / maxHp

func _process(_delta: float) -> void:
	
	
	pass

func _on_area_entered(_area: Area2D) -> void:
	is_fading = true

func _on_area_exited(_area: Area2D) -> void:
	is_fading = false
