extends ByNodeScript

# You need 6 vars in custom_var of piranha:
#	attack_interval: float,
#	attack_thrower: Node2DCreation,
#	attack_amount: int,
#	attack_times: int,
#	attack_sound: AudioStream,
#	projectile_collision: bool

var attacked_times:int

var timer_fire:Timer


func _ready() -> void:
	node.stretched_out.connect(
		func() -> void:
			if !timer_fire: return
			timer_fire.start(vars.attack_interval)
			attacked_times = vars.attack_times
	)
	
	timer_fire = node.get_node_or_null(^"Fire")
	if !timer_fire: return
	timer_fire.timeout.connect(_shoot)


func _shoot() -> void:
	if attacked_times <= 0: return
	
	attacked_times -= 1
	
	var thrower:Node2DCreation = vars.attack_thrower as Node2DCreation
	
	if !thrower: return
	
	for i in vars.attack_amount:
		thrower.prepare(node, node)
		
		var ball:Node2D = thrower.node
		if &"belongs_to" in ball: ball.belongs_to = Data.PROJECTILE_BELONGS.ENEMY
		
		if !vars.projectile_collision && ball is CollisionObject2D: ball.set_collision_mask_value(7,false)
		
		thrower.call_physics().apply_velocity_local().override_gravity().unbind()
		
		if ball is GravityBody2D: 
			ball.rotation = 0.0
			ball.speed = ball.speed.rotated(node.rotation)
		
		thrower.create()
	
	Audio.play_sound(vars.attack_sound, node)
	
	timer_fire.start(vars.attack_interval)
