extends ByNodeScript

var player: Player = Thunder._current_player

func _physics_process(delta: float) -> void:
	super(delta)
	
	if player.states.projectiles_count <= 0 || player.states.current_state == "dead":
		return
	
	if Input.is_action_just_pressed("m_run"):
		var set_speed: Callable = func(ins: GravityBody2D) -> void:
			ins.speed = vars.bullet_speed
			if player.sprite.flip_h: ins.speed.x = -abs(ins.speed.x)
		
		NodeCreator.create_ins_2d(vars.bullet, player, true, {}, set_speed).get_node()
		
		player.states.projectiles_count -= 1
		player.states.launch_timer = 2
		
		Audio.play_sound(
			preload("res://modules/base/objects/projectiles/sounds/shoot.wav"),
			player
		)
