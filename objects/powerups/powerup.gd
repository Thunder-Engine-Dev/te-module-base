extends GravityBody2D
class_name Powerup

@export_category("PowerupSettings")
@export var deep_snap: bool = true
@export var kinematic_movement: bool = true
@export var set_player_state: PlayerStateData
@export var appear_distance: float = 32
@export var appear_speed: float = 0.5
@export var score: int = 1000

@export_category("SFX")
@export var pickup_powerup_sound: AudioStream = preload("res://modules/base/objects/mario/sounds/powerup.wav")
@export var pickup_neutral_sound: AudioStream = preload("res://modules/base/objects/mario/sounds/powerup.wav")

@onready var body: Area2D = $Body


func _physics_process(delta: float) -> void:
	if !appear_distance:
		motion_process(Thunder.get_delta(delta), deep_snap, kinematic_movement)
	else:
		appear_process(Thunder.get_delta(delta))
	
	if body.overlaps_body(Thunder._current_player):
		collect()


func appear_process(delta: float) -> void:
	appear_distance = max(appear_distance - appear_speed * delta, 0)
	position -= Vector2(0, appear_speed).rotated(global_rotation) * delta


func collect() -> void:
	if set_player_state.player_power > Thunder._current_player_state.player_power:
		if Thunder._current_player_state.player_power < set_player_state.player_power - 1:
			Thunder._current_player.powerup(set_player_state.powerdown_state)
		else:
			Thunder._current_player.powerup(set_player_state)
		Audio.play_sound(pickup_powerup_sound, self)
	else:
		Audio.play_sound(pickup_neutral_sound, self)
	
	queue_free()
