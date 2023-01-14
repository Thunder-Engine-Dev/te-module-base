extends GravityBody2D

@export_category("GeneralMovementEnemy")
@export var look_at_player: bool = false
@export var rigid_movement: bool = false


func _ready() -> void:
	if look_at_player && Thunder._current_player:
		speed.x *= global_transform.affine_inverse().basis_xform(global_position.direction_to(Thunder._current_player.global_position).sign()).x

func _physics_process(delta: float) -> void:
	gravity_process()
	motion_process(Thunder.get_delta(delta),true,false,rigid_movement)
