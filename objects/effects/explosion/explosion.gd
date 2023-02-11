extends AnimatedSprite2D
class_name ExplosionEffect

func _init(pos: Vector2 = Vector2.ZERO):
	sprite_frames = preload("res://modules/base/objects/effects/explosion/explosion.tres")
	global_position = pos
	modulate.v = 1.2
	z_index = 1
	play('default')
	
	Scenes.current_scene.add_child(self)
	
	
	animation_finished.connect(queue_free)
