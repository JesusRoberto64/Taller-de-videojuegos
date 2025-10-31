extends Node

@onready var now_playign = $music_normal

func play_music(intense: int = 1) -> void:
	var postion = now_playign.get_playback_position()
	match intense:
		1:
			$music_normal.play(postion)
			now_playign = $music_normal
		2:
			$music_intense.play(postion)
			now_playign = $music_intense
			$music_normal.stop()


func stop_music() -> void:
	now_playign.stop()
