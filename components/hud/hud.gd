extends CanvasLayer

@export var time: int = 360

@onready var timer = $Timer
@onready var gameover = $Control/GameOver

func _ready() -> void:
	Thunder._current_hud = self
	
	timer.timeout.connect(func():
		Data.values.time -= 1
	)

func game_over() -> void:
	gameover.show()
	
	get_tree().create_timer(5, false).connect("timeout", func():
		print('over.')
	)
