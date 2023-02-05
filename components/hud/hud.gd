extends CanvasLayer

@export var time: int = 360

@onready var timer = $Timer
@onready var time_text = $Control/Time
@onready var gameover = $Control/GameOver

func _ready() -> void:
	Thunder._current_hud = self
	
	timer.timeout.connect(func():
		if Data.values.time < 0: return
		
		Data.values.time -= 1
		
		if Data.values.time == 100:
			timer_hurry()
		elif Data.values.time == 0:
			Thunder._current_player.kill()
	)

func game_over() -> void:
	gameover.show()
	
	get_tree().create_timer(5, false).connect("timeout", func():
		print('over.')
	)

func timer_hurry() -> void:
	Audio.play_1d_sound(preload("res://modules/base/components/hud/sounds/timeout.wav"))
	var tw = get_tree().create_tween().set_loops(8)
	tw.tween_property(time_text, "scale:y", 0.5, 0.125)
	tw.tween_property(time_text, "scale:y", 1, 0.125)
