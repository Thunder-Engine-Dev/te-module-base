extends GeneralMovementBody2D

enum Belongs {PLAYER, ENEMY}

@export var jumping_speed: float = -250.0
@export var belongs_to: Belongs = Belongs.PLAYER

@onready var texture:Sprite2D = $Texture


func _ready():
	super()

func _physics_process(delta: float) -> void:
	super(delta)
	
	texture.rotation_degrees += 12 * (-1 if speed.x < 0 else 1) * Thunder.get_delta(delta)


func jump(jspeed:float = jumping_speed) -> void:
	super(jspeed)

func explode():
	ExplosionEffect.new(position)
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_tree_exited():
	if belongs_to == Belongs.PLAYER:
		Thunder._current_player.projectiles_count += 1
