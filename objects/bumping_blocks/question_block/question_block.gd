@icon("res://modules/base/objects/bumping_blocks/question_block/textures/icon.png")
extends StaticBumpingBlock

func _physics_process(delta):
	var player = Thunder._current_player
	
	if player.is_on_ceiling() && !triggered:
		for i in player.get_slide_collision_count():
			var slide = player.get_slide_collision(i)
			
			var collider
			if !slide.has_method(&"get_collider"): continue
			collider = slide.get_collider()
			
			print(collider, i)
			if collider == self:
				triggered = true
				bump(true)
				$AnimatedSprite2D.animation = &"empty"
				continue
