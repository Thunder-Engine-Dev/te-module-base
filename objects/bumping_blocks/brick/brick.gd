@icon("res://modules/base/objects/bumping_blocks/question_block/textures/icon.png")
extends StaticBumpingBlock

const NULL_TEXTURE = preload("res://engine/scripts/classes/bumping_block/texture_null.png")

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var item_displayer = $ItemDisplayer
var current_displaying_item: String = ""


func _ready() -> void:
	super()


func _physics_process(delta):
	super(delta)
	
	if _triggered: return
	
	var player = Thunder._current_player
	if is_player_colliding(cast_below) && player.velocity_local.y <= 50 && !player.is_on_floor():
		if Thunder._current_player_state.player_power == Data.PLAYER_POWER.SMALL:
			bump(false)
