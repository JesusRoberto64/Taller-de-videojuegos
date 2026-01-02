extends CanvasLayer

var scene = ""

func _ready() -> void:
	$Coop.grab_focus()
	$AnimationPlayer.play("fade_out")

func _on_coop_pressed() -> void:
	scene = "res://Escenas/Fantasmas/Escenas/main.tscn"
	$AnimationPlayer.play("fade_in")
	$accept_sfx.play()

func _on_sobrevivencia_pressed() -> void:
	scene = "res://Escenas/Fantasmas/Escenas/main_survivor.tscn"
	$AnimationPlayer.play("fade_in")
	$accept_sfx.play()

func _on_salir_pressed() -> void:
	get_tree().quit()

func change_scene() -> void:
	get_tree().change_scene_to_file(scene)
