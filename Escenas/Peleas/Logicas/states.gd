extends Node

enum STATE {READY, MOVE, PUNCHING, HURT}
var cur_state = STATE.READY

var movement : Node = null
var punches : Node = null
var damage : Node = null

func set_logic(_movement, _punches, _damage):
	movement = _movement
	punches = _punches
	damage = _damage
