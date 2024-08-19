extends StaticBody2D

class_name Building

enum Size {Small = 1, Medium = 2, Large = 3}

@export var size: Size
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	$Buildings.get_child(rng.randi_range(0, get_child_count() - 1)).visible = true
