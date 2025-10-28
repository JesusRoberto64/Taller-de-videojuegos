## ESCENA PRINCIPAL DE MODO SUPERVIVENCIA
extends OverlordCoop

func _ready() -> void:
	timer_game = 0.0
	timer_lab.text = ".%02d" % timer_game
	players = get_tree().get_nodes_in_group("Player")
	for player in players:
		player.connect("get_alma", get_alma)
	# HUB
	Invoker.connect("no_ghost", no_ghost)
	finish.connect(Pause.finish)

func _process(delta: float) -> void:
	match cur_state:
		STATE.READY:
			timer -= delta
			if timer <= 0.0:
				timer = 5.0
				ready_lab.hide()
				anim.play("vinnet")
				cur_state = STATE.GAME
		STATE.GAME:
			timer_game += delta
			timer_lab.text = ".%02d" % timer_game
			if timer_game <= 0.0:
				timer_game = 0.0
				cur_state = STATE.GAMEOVER
				anim.play_backwards("vinnet")
				ready_lab.show()
				ready_lab.text = "¡FELIZ HALLOWEEN!"
				survived = true
				finish.emit()
			
			# Spawn rules
			wave(delta)
			
			# Two scared
			if players[0].scared == true:
				cur_state = STATE.GAMEOVER
				ready_lab.show()
				ready_lab.text = "GAME OVER"
				loose = true
				finish.emit()
		STATE.GAMEOVER:
			for f in Fantasmas.get_children():
				if f is Fantasma:
					f.disappear()
				else:
					f.queue_free()
			if loose:
				for p in players:
					p.loose()
			elif survived:
				for p in players:
					p.celebration()
				
