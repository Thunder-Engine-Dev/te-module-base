extends GeneralMovementBody2D

enum BELONGS {
	PLAYER,
	ENEMY
}
var belongs: int = BELONGS.PLAYER

func _ready():
	super()

func _physics_process(delta: float) -> void:
	super(delta)
	
	if is_on_floor():
		jump(-250)
	
	if is_on_wall():
		explode()
	
	$Texture.rotation_degrees += 12 * (-1 if speed.x < 0 else 1) * Thunder.get_delta(delta)

func explode():
	ExplosionEffect.new(position)
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_tree_exited():
	if belongs == BELONGS.PLAYER:
		Thunder._current_player.projectiles_count += 1
