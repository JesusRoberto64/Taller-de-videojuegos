extends Fantasma

# Fantasma movimento arriva abajo

func _ready() -> void:
	anim_player.connect('animation_finished',_on_animation_finished)
	spr.hide()
	invoke()

func _physics_process(delta: float) -> void:
	fading(delta)
	movement(delta)
