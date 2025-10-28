extends CanvasLayer

@onready var continua : Button = $Continua
@onready var reiniciar : Button = $Reiniciar
@onready var menu : Button = $Menu

var is_finished = false

func _ready() -> void:
	hide()

func _process(_delta: float) -> void:
	var is_pause = Input.is_action_just_pressed("ui_accept")
	if is_pause and not is_finished:
		if not get_tree().paused:
			get_tree().set_pause(true)
			show()
			continua.grab_focus()
		else:
			# quitar pause importante
			get_tree().set_pause(false)
			
			if reiniciar.has_focus():
				get_tree().reload_current_scene()
			elif menu.has_focus():
				get_tree().change_scene_to_file("res://Escenas/Coop/Escenas/main_menu.tscn")
			# hasta el final porque se cancela el focus
			hide() 
	elif is_pause and is_finished:
		if reiniciar.has_focus():
			get_tree().reload_current_scene()
		elif menu.has_focus():
			get_tree().change_scene_to_file("res://Escenas/Coop/Escenas/main_menu.tscn")

func finish() -> void:
	show()
	reiniciar.grab_focus()
	continua.hide()
	$ColorRect.hide()
	$Pause.hide()
	is_finished = true
