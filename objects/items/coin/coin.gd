extends Area2D

const coin_effect: PackedScene = preload("res://modules/base/objects/effects/coin_effect/coin_effect.tscn")

@export var sound: AudioStream = preload("res://modules/base/objects/items/coin/coin.wav")


func _from_bumping_block() -> void:
	Audio.play_sound(sound, self)
	NodeCreator.prepare_2d(coin_effect, self).create_2d().bind_global_transform()
	Data.add_coin()
	queue_free()

func _physics_process(delta):
	if overlaps_body(Thunder._current_player):
		collect()


func collect() -> void:
	Data.values.coins += 1
	if Data.values.coins > 99:
		Data.values.coins = 0
		Thunder.add_lives(1)
	
	NodeCreator.prepare_2d(coin_effect, self).call_method( func(eff: Node2D) -> void:
		eff.explode()
	).create_2d().bind_global_transform()
	
	Audio.play_sound(sound, self)
	queue_free()
