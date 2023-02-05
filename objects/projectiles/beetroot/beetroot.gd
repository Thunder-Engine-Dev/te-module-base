extends GeneralMovementBody2D

enum Belongs {
	PLAYER,
	ENEMY
}

@export var belongs_to: Belongs = Belongs.PLAYER
@export var jumping_speed: float = -450.0
@export var bounces_left: int = 3

var skip_frame: bool = false
var drown: bool = false

@onready var detector:ShapeCast2D = $Attack

signal run_out


func _ready() -> void:
	super()

#func _process(_delta: float) -> void:
#	for i in detector.get_collision_count():
#		var body:Node2D = detector.get_collider(i) as Node2D
#		if !body: return
#
#		if skip_frame:
#			break
#		if body is TileMap && body.is_in_group('Solid') && body.visible:
#			bounce()
#			skip_frame = true
#			break


func bounce(with_sound:bool = true, ceiling:bool = false) -> void:
	if bounces_left <= 0: return
	
	if with_sound:
		Audio.play_sound(preload("res://modules/base/objects/projectiles/sounds/stun.wav"), self)
	
	turn_x()
	if !ceiling: jump(jumping_speed)
	else: vel_set_y(0)
	
	bounces_left -= 1
	ExplosionEffect.new(position)
	
	if bounces_left == 0:
		run_out.emit()
		collision_layer = 0
		collision_mask = 0


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_tree_exited():
	if belongs_to == Belongs.PLAYER:
		Thunder._current_player.projectiles_count += 1
