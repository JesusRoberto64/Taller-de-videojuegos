extends Node2D

@onready var Player = $player
@onready var Gifts = $Gifts
var player_invoker = null

@onready var Parallax = $Parallax2D

var max_inetval = 1.0
var min_interval = 0.0
var level_width = 1000.0

func _ready():
	var invokers = get_tree().get_nodes_in_group("Invoker")
	for i in invokers:
		player_invoker = i
		player_invoker.set_node_gifts(Gifts)
		break
	

func _physics_process(_delta):
	#if Player.mov_anim != Vector2.ZERO:
		#Parallax.autoscroll.x = 5.0 * -Player.direction
	
	if Player.position.x > level_width * max_inetval:
		max_inetval += 1
		min_interval += 1
		$Level.position.x += level_width
	elif Player.position.x < level_width * min_interval:
		min_interval -= 1
		max_inetval -= 1
		$Level.position.x -= level_width
