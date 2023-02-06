extends ScoreText
class_name ScoreTextLife

func _init(string: String, ref: Node2D):
	super(string, ref)
	
	label_settings = LabelSettings.new()
	label_settings.font = preload("res://modules/base/components/score/fonts/life.fnt")
