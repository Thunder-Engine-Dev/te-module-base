extends Node2D

const CoinEffect: PackedScene = preload("res://modules/base/objects/effects/coin_effect/coin_effect.tscn")

func _ready() -> void:
	var set_effect: Callable = func(eff: Node2D) -> void:
		await get_tree().process_frame
		eff.global_transform = global_transform
	NodeCreator.create_2d(CoinEffect, self, false, set_effect)
	
	Data.values.coins += 1
	if Data.values.coins > 99:
		Data.values.coins = 0
		Thunder.add_lives(1)
	
	visible = false
