@icon("res://modules/base/objects/bumping_blocks/question_block/textures/icon.png")
@tool
extends StaticBumpingBlock

func _ready() -> void:
	if Engine.is_editor_hint(): return
	
	super()
	
	if area_below: area_below.body_entered.connect(_detect_below)

#func _physics_process(delta):
#	super(delta)

func _detect_below(body) -> void:
	if triggered: return
	
	if body is Player:
		if body.velocity_local.y <= 0 && !body.is_on_floor():
			call_bump()
			return

func call_bump() -> void:
	bump(true)
	$AnimatedSprite2D.animation = &"empty"


