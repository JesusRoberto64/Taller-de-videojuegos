extends Fantasma

func _ready() -> void:
	anim_player.connect('animation_finished',_on_animation_finished)
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)
	spr.hide()
	invoke()
	starting_point()
	dist = 10.0

func starting_point() -> void:
	direction = [-1.0, 1.0].pick_random()
	if direction < 0.0: # is es negativa
		position.y = 180 + 24
		spr.flip_h = false
	else:
		position.y = -24
		spr.flip_h = true
	position.x = randf_range(24.0, 290.0)
	pos.x = position.x

func _physics_process(delta: float) -> void:
	fading(delta)
	movement(delta)

func movement(delta):
	if !can_move: return
	position.y += delta * speed * direction
	radian += delta * 5.0
	position.x = pos.x + (sin(radian) * dist)
	
	if position.y < -30.0 or position.y > 210.0:
		starting_point()

#func revive() -> void:
	#queue_free()
	#starting_point()
	#hp = maxHp
	#anim_player.play("apearing")
	#radian = 0.0
	#direction *= -1
