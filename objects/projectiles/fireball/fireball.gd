extends GeneralMovementBody2D

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
