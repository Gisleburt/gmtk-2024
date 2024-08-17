extends Node2D

var initial_speed_min: float = 20
var initial_speed_max: float = 50

@onready var rng = RandomNumberGenerator.new()

func _ready() -> void:
	var initial_speed = rng.randf_range(initial_speed_min, initial_speed_min)
	var initial_direction = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1)).normalized()
	$RigidBody2D.set_linear_velocity(initial_direction * initial_speed)
