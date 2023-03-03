@icon("res://modules/base/objects/bumping_blocks/question_block/textures/icon.png")
@tool
extends StaticBumpingBlock

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var item_displayer = $ItemDisplayer


func _ready() -> void:
	if Engine.is_editor_hint(): return
	item_displayer.queue_free()
	
	super()

func _physics_process(delta):
	super(delta)
	if Engine.is_editor_hint(): return
	
	if _triggered: return
	
	var player = Thunder._current_player
	if is_player_colliding(cast_below) && player.velocity_local.y <= 50 && !player.is_on_floor():
		call_bump()

func call_bump() -> void:
	bump(true)
	animated_sprite_2d.animation = &"empty"
