extends AnimatedSprite2D

var exploded: bool


func _ready() -> void:
	if exploded: return
	var pos: Vector2 = position
	var tw: Tween = create_tween()
	tw.tween_property(self, "position",(pos + Vector2(0,-64)).rotated(rotation),0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tw.tween_callback(_fall)


func _fall() -> void:
	var pos: Vector2 = position
	var tw: Tween = create_tween()
	tw.tween_property(self,"position",(pos + Vector2(0,12)).rotated(rotation),0.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	tw.tween_callback(explode)


func explode() -> void:
	exploded = true
	play.call_deferred(&"explosion")
	animation_finished.connect(queue_free,CONNECT_REFERENCE_COUNTED)
