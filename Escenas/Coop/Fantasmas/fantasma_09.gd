extends Fantasma

# Fantasma movimento arriva abajo
var vec_direction : Vector2 = Vector2(1.0,1.0)
var hited_timer = 0.5

func _ready() -> void:
	anim_player.connect('animation_finished',_on_animation_finished)
	connect("area_entered", _on_area_entered)
	spr.hide()
	invoke()

func _physics_process(delta: float) -> void:
	fading(delta)
	movement(delta)

func movement(delta) -> void:
	if !can_move: return
	position += vec_direction * speed * delta
	
	if position.x > 320.0 or position.x < 0.0:
		vec_direction.x *= -1.0
	if position.y > 180.0 or position.y < 0.0:
		vec_direction.y *= -1.0

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
	
	hited_timer -= delta
	if hited_timer <= 0.0:
		scale -= Vector2(0.25, 0.25)
		scale.x = max(scale.x, 0.5)
		scale = Vector2(scale.x, scale.x)
		speed += 7.0
		instance_alma(position)
		hited_timer = 0.5
