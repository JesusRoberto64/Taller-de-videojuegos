extends Node2D

enum STATE {READY, GAME, GAMEOVER, PAUSE}
var cur_state = STATE.READY
var level = 1

var almas : int = 0
var players : Array = []

@onready var Fantasmas = $Fantasmas
@onready var Invoker = $Invoker
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var almas_lab = $CanvasLayer/almas
@onready var ready_lab = $CanvasLayer/Ready
@onready var timer_lab = $CanvasLayer/Timer

var timer : float = 4.0 
var timer_game : float = 50.0

var is_invoking : float = false

func _ready() -> void:
	var seconds = fmod(timer_game, 60)
	var minutes = fmod(timer_game, 3600) / 60
	timer_lab.text = "%02d : %02d" % [minutes, seconds]
	
	
	players = get_tree().get_nodes_in_group("Player")
	for player in players:
		player.connect("get_alma", get_alma)
	
	# HUB
	Invoker.connect("no_soul", no_soul)

func _process(delta: float) -> void:
	match cur_state:
		STATE.READY:
			timer -= delta
			if timer <= 0.0:
				timer = 5.0
				ready_lab.hide()
				anim.play("vinnet")
				cur_state = STATE.GAME
				Invoker.invoke(Fantasmas, 1,level)
			pass
		STATE.GAME:
			timer_game -= delta
			if timer_game <= 0.0:
				timer_game = 0.0
				cur_state = STATE.GAMEOVER
				anim.play_backwards("vinnet")
				ready_lab.show()
				ready_lab.text = "¡FELIZ HALLOWEEN!"
			var seconds = fmod(timer_game, 60)
			var minutes = fmod(timer_game, 3600) / 60
			timer_lab.text = "%02d : %02d" % [minutes, seconds]
			
			# Two scared
			var scared = 0
			for p in players:
				if p.scared == true:
					scared += 1
			if scared >= 2:
				cur_state = STATE.GAMEOVER
				#anim.play_backwards("vinnet")
				ready_lab.show()
				ready_lab.text = "¡GAME OUVA!"
				
			pass
		STATE.GAMEOVER:
			for f in Fantasmas.get_children():
				if f is Fantasma:
					f.disappear()
				else:
					f.queue_free()
	
	if Input.is_action_just_released("ui_undo"):
		get_tree().reload_current_scene()
	

func get_alma() -> void:
	almas += 1
	almas = min(almas, 9999)
	almas_lab.text = "x %0004d" % [almas]

func no_soul():
	level += 1
	Invoker.invoke(Fantasmas, 1,level)
