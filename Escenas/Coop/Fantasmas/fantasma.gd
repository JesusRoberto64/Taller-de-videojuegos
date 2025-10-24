class_name Fantasma
extends Area2D

@export var maxHp : float = 10.0
var hp : float = maxHp
signal destroyed(fantasma : Fantasma)

@export var speed : float = 40.0

var is_fading : bool = false

@onready var spr : AnimatedSprite2D = $sprite

var light_power : float = 40.0
var light_mult : float = 0.2

var pos : Vector2
var radian : float = 0.0
var dist: float ## La vida del fantasma
var direction : float = 1.0
var can_move : bool = false

@onready var particles : GPUParticles2D = $particles
@onready var anim_player : AnimationPlayer = $AnimationPlayer

# Almas
var alma = preload("res://Escenas/Coop/alma.tscn")

func invoke() -> void:
	dist = randf_range(20.0,45.0)
	$Timer.connect("timeout", revive)
	position = Vector2(randf_range(36.0, 280.0), randf_range(36.0, 150.0))
	pos = position
	# Apear
	$CollisionShape2D.disabled = true
	anim_player.play("apearing")

func fading(delta) -> void:
	if !is_fading: return
	hp -= delta * (light_power * light_mult)
	hp = max(hp, 0.0)
	spr.modulate.a = hp / maxHp
	if hp == 0.0:
		destroyed.emit(self)
		$Timer.start()
		$CollisionShape2D.disabled = true
		can_move = false
		instance_alma(position)

func movement(delta) -> void:
	if !can_move : return
	radian += delta
	position.x = pos.x + (sin(radian))*dist
	if position.y <= 0.0:
		position.y = 1.0
		direction = 1.0
	elif position.y >= 180.0:
		position.y = 179.0
		direction = -1.0
	position.y += delta*speed*direction

func _on_area_entered(_area: Area2D) -> void:
	is_fading = true
	light_mult += 0.4
	if not anim_player.is_playing():
		anim_player.play("hurting")

func _on_area_exited(_area: Area2D) -> void:
	is_fading = false
	light_mult -= 0.4
	anim_player.stop()

func revive() -> void:
	queue_free()
	#position = Vector2(randf_range(36.0, 280.0), randf_range(36.0, 150.0))
	#pos = position
	#hp = maxHp
	#anim_player.play("apearing")
	#radian = 0.0
	#direction *= -1

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name != "apearing": return
	$CollisionShape2D.disabled = false
	can_move = true

func instance_alma(_pos: Vector2) -> void:
	var a : Area2D = alma.instantiate()
	a.position = _pos
	get_parent().add_child(a)

func disappear() -> void:
	$CollisionShape2D.disabled = true
	can_move = false
	anim_player.play("desappear")
