extends Node

var timer = 0.0
@onready var absorb_sfx = $Absorb

func play_absorb(delta) -> void:
	timer -= delta
	if timer <= 0.0:
		timer = 0.18
		absorb_sfx.play()

func play_appear() -> void:
	$Apear.play()

func play_desapear() -> void:
	$Desapear.play()
