extends Area2D

@onready var coll_shape : CollisionShape2D = $CollisionShape2D
@onready var rango_shape : CollisionShape2D = $rango/CollisionShape2D

var disapeared = false
var following = false
var target : Node2D = null

var jumpig : bool = true
var pos : Vector2 = Vector2.ZERO
var radian : float = 0.0
var dist : float = 30.0
var direction : float = 1.0
var cycles : int = 0


func _ready() -> void:
	connect("body_entered", _on_body_entered)
	$rango.connect("body_entered", _on_rango_body_entered)
	pos = position # para iniciar animación de salto

func _process(_delta: float) -> void:
	if disapeared: queue_free()

func _physics_process(delta: float) -> void:
	if following:
		var target_pos = target.global_position
		global_position = global_position.move_toward(target_pos, delta*100.0)
	elif jumpig:
		# Salto
		if cycles >= 3:
			jumpig = false
			rango_shape.disabled = false
		radian += delta * 6.0
		position.y = pos.y - abs(sin(radian)) * dist
		if radian >= PI:
			radian -= PI
			dist *= 0.6
			cycles += 1
		# Desplazamiento
		position.x += delta * (dist*0.5) * direction

func _on_body_entered(body : Node2D) -> void:
	body.emit_signal("get_alma")
	coll_shape.call_deferred('set_disabled', true)
	disapeared = true

func _on_rango_body_entered(body: Node2D) -> void:
	following = true
	target = body
	rango_shape.call_deferred('set_disabled', true)
