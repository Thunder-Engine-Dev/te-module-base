extends CanvasLayer

@export var time: int = 360

@onready var timer = $Timer

func _ready() -> void:
	timer.timeout.connect(func():
		Data.values.time -= 1
	)
