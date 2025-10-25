extends Fantasma

var vec_direction : Vector2 = Vector2(1.0,1.0)
var target = null

func _ready() -> void:
	anim_player.connect('animation_finished',_on_animation_finished)
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)
	spr.hide()
	invoke()
	target = get_tree().get_nodes_in_group("Player").pick_random()

func _physics_process(delta: float) -> void:
	fading(delta)
	movement(delta)

func movement(delta) -> void:
	if !can_move: return
	position = lerp(position, target.position, delta)

#func revive() -> void:
	#queue_free()
	#position = Vector2(randf_range(36.0, 280.0), randf_range(36.0, 150.0))
	#pos = position
	#hp = maxHp
	#anim_player.play("apearing")
	#target = get_tree().get_nodes_in_group("Player").pick_random()
