extends InstanceNode2D
class_name PowerupCreation

@export_category("InstanceNode2D")
@export_group("Creation","creation_")
@export var creation_fallback_node: PackedScene = preload("res://modules/base/objects/powerups/red_mushroom/red_mushroom.tscn")


func prepare() -> Variant:
	if !creation_nodepack: return self
	if (
		creation_fallback_node &&
		creation_nodepack.resource_path != creation_fallback_node.resource_path &&
		Thunder._current_player_state.player_power == Data.PLAYER_POWER.SMALL
	):
		creation_nodepack = creation_fallback_node
	return self
