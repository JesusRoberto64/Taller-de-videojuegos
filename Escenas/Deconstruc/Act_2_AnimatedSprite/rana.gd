extends AnimatedSprite2D # Una acción

func _ready():
	animation_finished.connect(on_animation_finished)

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") and animation != "action":
		play("action")

func on_animation_finished():
	play("default")
