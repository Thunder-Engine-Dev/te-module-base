@icon("res://modules/base/objects/bumping_blocks/question_block/textures/icon.png")
extends StaticBumpingBlock

const NULL_TEXTURE = preload("res://engine/scripts/classes/bumping_block/texture_null.png")
const DEBRIS_EFFECT = preload("res://modules/base/objects/effects/brick_debris/brick_debris.tscn")

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
		else:
			Audio.play_sound(break_sound, self)
			var speeds = [Vector2(2, -8), Vector2(4, -7), Vector2(-2, -8), Vector2(-4, -7)]
			for i in speeds:
				NodeCreator.create_2d(DEBRIS_EFFECT, self, true, func(eff: Node2D):
					eff.global_transform = global_transform
					eff.velocity = i
				)
			
			Data.values.score += 50
			queue_free()
