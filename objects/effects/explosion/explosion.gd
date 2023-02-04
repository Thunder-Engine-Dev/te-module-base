extends AnimatedSprite2D
class_name ExplosionEffect

func _init(pos: Vector2 = Vector2.ZERO):
	Thunder._current_stage.add_child(self)
	
	sprite_frames = preload("res://modules/base/objects/effects/explosion/explosion.tres")
	global_position = pos
	modulate.v = 1.2
	z_index = 1
	play('default')
	
	
	animation_finished.connect(func(): queue_free())
