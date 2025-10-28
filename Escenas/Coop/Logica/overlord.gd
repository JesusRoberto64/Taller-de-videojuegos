class_name OverlordCoop
extends Node2D

enum STATE {READY, GAME, GAMEOVER, PAUSE}
var cur_state = STATE.READY
var level = 1
var speed_mult = 1

var almas : int = 0
var players : Array = []

@onready var Fantasmas = $Fantasmas
@onready var Invoker = $Invoker
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var almas_lab = $CanvasLayer/almas
@onready var ready_lab = $CanvasLayer/Ready
@onready var timer_lab = $CanvasLayer/Timer
@onready var Pause = $Pause

var timer : float = 4.0 
var timer_game : float = 120.0

var is_invoking : float = false
# Rules
var wave_timer : float = 1.25
var invoke_timer : float = 1.0
var is_wave : bool = true 
var invoke_counter = 1
var ghost_counter = 1
var max_ghost = 1

var loose = false
var survived = false
signal finish

func _ready() -> void:
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
			timer_game -= delta
			timer_lab.text = ".%02d" % timer_game
			#timer_lab.text = chronometer_label(timer_game)
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
			var scared = 0
			for p in players:
				if p.scared == true:
					scared += 1
			if scared >= 2:
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
				

func get_alma() -> void:
	almas += 1
	almas = min(almas, 9999)
	almas_lab.text = "-/%0004d" % [almas]

func wave(delta: float) -> void:
	if not is_wave:
		wave_timer -= delta
		if wave_timer <= 0.0:
			wave_timer = 1.25
			is_wave = true
	else:
		if invoke_counter > 0:
			invoke_timer -= delta
			if invoke_timer <= 0.0:
				Invoker.invoke(Fantasmas, level, speed_mult)
				invoke_timer = 1.0
				invoke_counter -= 1
	if ghost_counter <= 0:
		is_wave = false
		max_ghost += 1
		ghost_counter = max_ghost
		invoke_counter = max_ghost
		invoke_timer = 1.0
		wave_timer = 1.25
		level += 1
		if level % 7 == 0:
			max_ghost = 1
			ghost_counter = max_ghost
			invoke_counter = max_ghost
			speed_mult += 1

func no_ghost():
	ghost_counter -= 1

func chronometer_label(_timer) -> String:
	var seconds = fmod(_timer, 60)
	var minutes = fmod(_timer, 3600) / 60
	return "%02d : %02d" % [minutes, seconds]
