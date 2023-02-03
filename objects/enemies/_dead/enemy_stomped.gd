extends GeneralMovementBody2D

@onready var collsion_box:CollisionShape2D = $Collision


func _ready() -> void:
	for i in get_children():
		if i is Sprite2D:
			collsion_box.shape.size = i.texture.get_size()
		elif i is AnimatedSprite2D:
			collsion_box.shape.size = i.sprite_frames.get_frame_texture(i.animation,i.frame).get_size()
