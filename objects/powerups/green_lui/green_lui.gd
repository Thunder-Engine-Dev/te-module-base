extends Powerup

const JUMP_SOUND = preload("res://modules/base/objects/mario/sounds/kick.wav")

func _physics_process(delta: float) -> void:
	super(delta)
	if is_on_floor() && !appear_distance:
		jump(350)
		Audio.play_sound(JUMP_SOUND, self)
