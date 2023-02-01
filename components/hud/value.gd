extends Label

var value_template: String
@export var value_name: String

func _ready():
	value_template = text
	assert(value_name in Data.values, "Value " + value_name + " does not exist in Data.values dictionary.")


func _physics_process(delta):
	text = value_template % Data.values[value_name]
