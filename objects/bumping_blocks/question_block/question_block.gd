@icon("res://modules/base/objects/bumping_blocks/question_block/textures/icon.png")
@tool
extends StaticBumpingBlock

const NULL_TEXTURE = preload("res://engine/scripts/classes/bumping_block/texture_null.png")

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var item_displayer = $ItemDisplayer
var current_displaying_item: String = ""


func _ready() -> void:
	if Engine.is_editor_hint():
		_item_display()
		return
	
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


func _item_display() -> void:
	if !result || !result.creation_node: return _item_display_reset()
	if result.creation_node.resource_path == current_displaying_item: return
	
	var creation_scene = result.creation_node.instantiate()
	var sprite = Thunder.get_child_by_class_name(creation_scene, "Sprite2D") || Thunder.get_child_by_class_name(creation_scene, "AnimatedSprite2D")
	if !sprite: push_error("[QuestionBlock] Failed to retrieve the preview of result")
	else:
		if is_instance_of(sprite, Sprite2D):
			item_displayer.texture = sprite.texture
		else:
			item_displayer.texture = sprite.sprite_frames.get_frame_texture(sprite.animation, 0)
	
	current_displaying_item = result.creation_node.resource_path

func _item_display_reset() -> void:
	if current_displaying_item == "": return
	
	item_displayer.texture = NULL_TEXTURE
	current_displaying_item = ""
