extends Area2D

@export var maxHp : float = 10.0
var hp = maxHp

var is_fading = false

@onready var spr = $sprite

var light_power : float = 40.0
var light_mult : float = 0.2

var pos : Vector2
var radian : float = 0.0
var dist: float
var direction = 1.0
var can_move = true

@onready var particles = $particles
@onready var anim_player = $AnimationPlayer

func _ready() -> void:
	dist = randf_range(20.0,45.0)
	$Timer.connect("timeout", revive)
	position = Vector2(randf_range(36.0, 280.0), randf_range(36.0, 150.0))
	pos = position

func _physics_process(delta: float) -> void:
	if is_fading:
		hp -= delta * (light_power * light_mult)
		hp = max(hp, 0.0)
		spr.modulate.a = hp / maxHp
		if hp == 0.0:
			$Timer.start()
			$CollisionShape2D.disabled = true
			can_move = false
	
	if can_move:
		radian += delta*5.0
		position.x = pos.x + (sin(radian))*dist
		if position.y <= 0.0:
			position.y = 1.0
			direction = 1.0
		elif position.y >= 180.0:
			position.y = 179.0
			direction = -1.0
			pass
		position.y += delta*40.0*direction

func _on_area_entered(_area: Area2D) -> void:
	is_fading = true
	light_mult += 0.4
	if not anim_player.is_playing():
		anim_player.play("hurting")

func _on_area_exited(_area: Area2D) -> void:
	is_fading = false
	light_mult -= 0.4
	anim_player.stop()

func revive():
	position = Vector2(randf_range(36.0, 280.0), randf_range(36.0, 150.0))
	pos = position
	hp = maxHp
	anim_player.play("apearing")
	particles.emitting = true
	radian = 0.0
	direction *= -1

func _on_animation_finished(_anim_name: StringName) -> void:
	$CollisionShape2D.disabled = false
	particles.emitting = false
	can_move = true
