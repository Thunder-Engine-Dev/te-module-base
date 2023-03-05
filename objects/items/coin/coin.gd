extends Area2D

func _physics_process(delta):
	if overlaps_body(Thunder._current_player):
		collect()


func collect() -> void:
	Data.values.coins += 1
	if Data.values.coins > 99:
		Data.values.coins = 0
		
	Audio.play_sound(preload("res://modules/base/objects/items/coin/coin.wav"), self)
	
	Classes.coin_effect.create(self,transform,true)
	queue_free()
