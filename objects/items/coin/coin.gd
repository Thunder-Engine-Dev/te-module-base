extends Area2D

const CoinEffect: PackedScene = preload("res://modules/base/objects/effects/coin_effect/coin_effect.tscn")


func _physics_process(delta):
	if overlaps_body(Thunder._current_player):
		collect()


func collect() -> void:
	Data.values.coins += 1
	if Data.values.coins > 99:
		Data.values.coins = 0
		Thunder.add_lives(1)
	
	var set_effect: Callable = func(eff: Node2D) -> void:
		eff.transform = transform
		eff.explode()
	NodeCreator.create_2d(CoinEffect, self, true, null, null, {}, set_effect)
	
	Audio.play_sound(preload("res://modules/base/objects/items/coin/coin.wav"), self)
	queue_free()
