extends StaticBody2D

@export var edible_value: float = 1


func _ready() -> void:
	$AnimatedSprite2D.play()


func get_value() -> float:
	return edible_value
