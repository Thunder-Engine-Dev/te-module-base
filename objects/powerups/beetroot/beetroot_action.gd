extends ByNodeScript

var beetroot = preload("res://modules/base/objects/projectiles/beetroot/beetroot.tscn")

@onready var player = Thunder._current_player

func _physics_process(delta: float) -> void:
	super(delta)
	
	if player.projectiles_count <= 0:
		return
	
	if Input.is_action_just_pressed("m_run"):
		var projectile = beetroot.instantiate()
		Thunder._current_stage.add_child(projectile)
		projectile.global_transform = player.global_transform
		projectile.position.y -= 36
		
		player.projectiles_count -= 1
		player.states.launch_timer = 2
		
		if player.sprite.flip_h:
			projectile.speed.x *= -1
		
		Audio.play_sound(
			preload("res://modules/base/objects/projectiles/sounds/shoot.wav"),
			player
		)
