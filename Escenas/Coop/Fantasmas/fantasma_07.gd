extends Fantasma

# Fantasma movimento arriva abajo

var is_close = true
var targets : Array = []
var target = null

func _ready() -> void:
	anim_player.connect('animation_finished',_on_animation_finished)
	targets = get_tree().get_nodes_in_group("Player")
	spr.hide()
	invoke()

func _physics_process(delta: float) -> void:
	fading(delta)
	movement(delta)
	
	if !is_close : return
	for t in targets:
		if t.position.distance_to(position) < 80.0:
			is_close = false
			target = t
			spr.play("attack")
			break
	

func movement(delta) -> void:
	if !can_move : return
	if is_close: return
	position = lerp(position, target.position, delta)

#func revive() -> void:
	#queue_free()
	#position = Vector2(randf_range(36.0, 280.0), randf_range(36.0, 150.0))
	#pos = position
	#hp = maxHp
	#anim_player.play("apearing")
	#
	#spr.play("default")
	#is_close = true
