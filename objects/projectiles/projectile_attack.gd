extends ShapeCast2D

@export var killer_type:StringName = Data.ATTACKERS.fireball
@export var special_tags:Array[StringName]

var velocity:Vector2

signal killed
signal killed_succeeded
signal killed_failed


func _process(delta: float) -> void:
	var par:GravityBody2D = get_parent() as GravityBody2D
	if !par: return
	
	velocity = par.velocity
	
	target_position = (velocity * get_physics_process_delta_time()).rotated(-global_rotation)
	
	var result:Dictionary 
	for i in get_collision_count():
		var ins:Area2D = get_collider(i) as Area2D
		if !ins: continue
		
		var enemy_attacked:Node = ins.get_node_or_null(^"EnemyAttacked")
		if !enemy_attacked: continue
		
		result = enemy_attacked.got_killed(killer_type, special_tags)
	if result.is_empty(): return
	elif result.result:
		killed.emit()
		killed_succeeded.emit()
		return
	else:
		killed.emit()
		killed_failed.emit()
		return
