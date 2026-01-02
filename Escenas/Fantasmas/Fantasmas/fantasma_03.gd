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
		position.x = 320.0 + 18.0
		spr.flip_h = true
	else:
		position.x = -18.0
		spr.flip_h = false
	position.y = randf_range(28.0, 122.0) 
	pos.y = position.y

func _physics_process(delta: float) -> void:
	fading(delta)
	movement(delta)

func movement(delta):
	if !can_move: return
	position.x += delta * speed * direction
	radian += delta * 5.0
	position.y = pos.y + (sin(radian) * dist)
	
	if position.x > 350.0 or position.x < -18.0:
		starting_point()

#func revive() -> void:
	#queue_free()
	#starting_point()
	#hp = maxHp
	#anim_player.play("apearing")
	#radian = 0.0
	#direction *= -1
