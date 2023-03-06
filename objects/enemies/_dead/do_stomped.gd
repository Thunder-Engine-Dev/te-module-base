extends ByNodeScript


func _ready() -> void:
	print(1)
	
	var spawner: Node = vars.spawner as Node
	var enemy_attacked: Node = vars.enemy_attacked as Node
	var death: NodePath = vars.death as NodePath
	
	if !spawner || !enemy_attacked || death.is_empty(): return
	
	print(enemy_attacked)
	
	var death_node: Node = enemy_attacked.get_node_or_null(death).duplicate()
	if !death_node: return
	
	node.add_child(death_node)
	print(node.get_children())
