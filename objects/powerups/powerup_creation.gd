extends Node2DCreation
class_name PowerupCreation

@export_category("Node2DCreation")
@export_group("Creation","creation_")
@export var creation_fallback_node: PackedScene = preload("res://modules/base/objects/powerups/red_mushroom/red_mushroom.tscn")

func prepare(caller: Node, on: Node2D) -> void:
	if (
		creation_fallback_node &&
		creation_node.resource_path != creation_fallback_node.resource_path &&
		Thunder._current_player_state.player_power == Data.PLAYER_POWER.SMALL
	):
		node = creation_fallback_node.instantiate()
	
	super(caller, on)
