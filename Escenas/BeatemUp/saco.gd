extends AnimatableBody2D

@onready var anim = $AnimationPlayer
@onready var col_shape = $CollisionShape2D
@onready var spr : Sprite2D = $Arbusto

@export var maxHp : int = 8
var hp = maxHp

var mov = 0.0
var radian = 0.0
var max_radian = PI/6.0

@onready var frames = spr.hframes * spr.vframes

func _physics_process(delta: float) -> void:
	if radian > 0.0:
		radian -= delta
		position.y += (sin(radian*12.0))

func hit_anim(elevation = 'none', hit = 1) -> void:
	if !anim.is_playing():
		anim.play("hited")
	if elevation != "none":
		radian = max_radian
	
	hp = max(hp - hit, 0)
	var hpPercent := float(hp) / float(maxHp)
	var damageFrame := int((1.0 - hpPercent) * (frames - 1))
	
	if hp > 0:
		spr.frame = min(damageFrame, frames - 2) # El 2 es para acabar en el penúltimo frame
	else:
		spr.frame = frames - 1 # El 1 es para tomar el último frame
		destroyed()

func destroyed() -> void:
	col_shape.call_deferred('set_disabled', true)
	anim.play("destroy")

func revive() -> void:
	col_shape.call_deferred('set_disabled', false)
	hp = maxHp

func start_timer() -> void:
	$Timer.start()

func _on_timer_timeout() -> void:
	anim.play("revive")
	spr.frame = 0
