extends StaticBody2D

@export_category("BulletBillLauncher")
@export_group("Bullet")
@export var bullet_bill:Node2DCreation
@export_group("Delay")
@export var first_shooting: float
@export var shooting_delay_min: float
@export var shooting_delay_max: float

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var launcher: Sprite2D = $Launcher
@onready var base: Control = $Base


func _ready() -> void:
	collision_shape.position.y = base.get_rect().get_center().y
	collision_shape.shape.size.y = base.get_rect().size.y
