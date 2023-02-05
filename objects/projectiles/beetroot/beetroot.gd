extends GeneralMovementBody2D

enum BELONGS {
	PLAYER,
	ENEMY
}
var belongs: int 

var bounces_left: int = 3
var skip_frame: bool = false
var drown: bool = false


func _ready() -> void:
	super()

func _physics_process(delta: float) -> void:
	super(delta)
	
	if bounces_left <= 0:
		return
	
	if is_on_floor() || is_on_wall() || is_on_slope():
		bounce()
		Audio.play_sound(preload("res://modules/base/objects/projectiles/sounds/stun.wav"), self)
	

func bounce() -> void:
	turn_x()
	jump(-450)
	bounces_left -= 1
	ExplosionEffect.new(position)
	
	if bounces_left == 0:
		collision_layer = 0
		collision_mask = 0


func _on_area_2d_body_entered(body) -> void:
	if body is GeneralMovementBody2D:
		pass
	
	if skip_frame:
		return
	if body is TileMap && body.is_in_group('Solid') && body.visible:
		bounce()
		Audio.play_sound(preload("res://modules/base/objects/projectiles/sounds/stun.wav"), self)
		skip_frame = true


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_tree_exited():
	if belongs == BELONGS.PLAYER:
		Thunder._current_player.projectiles_count += 1
