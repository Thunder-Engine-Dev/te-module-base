@icon("res://modules/base/objects/bumping_blocks/question_block/textures/icon.png")
extends StaticBumpingBlock

func _ready() -> void:
	super()
	
	if area_below: area_below.body_entered.connect(_detect_below)

#func _physics_process(delta):
#	super(delta)

func _detect_below(body) -> void:
	if triggered: return
	
	if body is Player:
		if body.velocity_local.y < body.config.max_fall_speed:
			call_bump()
			return
	

func call_bump() -> void:
	bump(true)
	$AnimatedSprite2D.animation = &"empty"


