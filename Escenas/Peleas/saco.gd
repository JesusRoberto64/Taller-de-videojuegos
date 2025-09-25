extends AnimatableBody2D

@onready var anim = $AnimationPlayer
@onready var col_shape = $CollisionShape2D

var hp : int = 8
var mov = 0.0
var radian = 0.0
var max_radian = PI/6.0

func _physics_process(delta: float) -> void:
	if radian > 0.0:
		radian -= delta
		position.y += (sin(radian*12.0))

func hit_anim(elevation = 'none', hit = 1) -> void:
	if !anim.is_playing():
		anim.play("hited")
	if elevation != "none":
		radian = max_radian
	
	hp -= hit
	if hp <= 0:
		destroyed()

func destroyed() -> void:
	col_shape.call_deferred('set_disabled', true)
	anim.play("destroy")

func revive() -> void:
	col_shape.call_deferred('set_disabled', false)
	hp = 7

func start_timer() -> void:
	$Timer.start()

func _on_timer_timeout() -> void:
	anim.play("revive")

func _on_animation_finished(_anim_name: StringName) -> void:
	
	pass # Replace with function body.
