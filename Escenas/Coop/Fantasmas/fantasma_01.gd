extends Fantasma

# Fantasma movimento arriva abajo

func _ready() -> void:
	invoke()

func _physics_process(delta: float) -> void:
	fading(delta)
	movement(delta)
