extends Powerup

func collect() -> void:
	Data.values.lives += 1
	ScoreText.new("1UP", self)
	Audio.play_sound(preload("res://modules/base/objects/mario/sounds/1up.wav"), self)
	queue_free()
