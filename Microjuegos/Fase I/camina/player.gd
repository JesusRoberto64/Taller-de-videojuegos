extends CharacterBody2D

var speed = 180.0
var move_anim = 0.0
@onready var anim = $AnimatedSprite2D

func _physics_process(_delta):
	var move = Input.get_axis("ui_left", "ui_right")
	move_anim = move
	
	velocity.x = move * speed
	move_and_slide()

func _process(_delta):
	if move_anim == 0.0:
		anim.play("idle")
	else:
		anim.play("walk")
		anim.flip_h = false if move_anim > 0.0 else true 
