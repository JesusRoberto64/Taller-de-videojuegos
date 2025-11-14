extends Node2D

var gift = preload("res://Escenas/Shooter/gift.tscn")
var gifts : Array = []
var timer : float = 0.0
var inerval = 0.15
var node_gifts: Node = self # nodo por default

var direction : float = 1.0
var mov : Vector2 = Vector2.ZERO
var force : float = 200.0 
const max_force : float = 800.0
const min_force : float = 200.0 
var height: float = 70.0 

@onready var spr = $Sprite2D

func set_node_gifts(_gifst : Node) -> void:
	node_gifts = _gifst

func _physics_process(delta):
	if timer > 0.0:
		timer -= delta
	
	if owner.direction != null:
		direction = owner.direction
		mov = owner.mov_anim
		get_parent().scale.x = direction # get ancher point
	
	if Input.is_action_pressed("jump"):
		force += delta * 700.0
		force = min(max_force, 0.0)
		var amount = force / max_force
		spr.offset.x = -40.0 * amount
	else:
		spr.offset.x = lerpf(spr.offset.x, 0.0, delta* 100.0)
	
	if Input.is_action_just_released("jump") and timer <= 0.0:
		timer = inerval
		var inst = gift.instantiate()
		inst.global_position = global_position
		inst.set_parable(direction, force)
		#if mov.x != 0.0:
			#inst.set_parable(direction, max_force)
		#else:
			#inst.set_parable(direction, min_force)
		node_gifts.add_child(inst)
		force = min_force
	elif Input.is_action_pressed('punch') and timer <= 0.0:
		timer = inerval
		var inst = gift.instantiate()
		inst.global_position = global_position
		inst.missile()
		inst.direction = direction
		#if mov.x != 0.0:
			#inst.force *= 2.0
		inst.force *= 0.0
		inst.gravity_force = 400.0
		node_gifts.add_child(inst)
