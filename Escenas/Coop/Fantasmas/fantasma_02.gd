extends Fantasma

var vec_direction : Vector2 = Vector2(1.0,1.0)
var speed : float = 150.0

func _ready() -> void:
	anim_player.connect('animation_finished',_on_animation_finished)
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)
	invoke()
	var numbers = [-1.0, 1.0, 0.5, -0.5, 0.25,-0.25]
	vec_direction = Vector2(numbers.pick_random() , numbers.pick_random()).normalized()

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
