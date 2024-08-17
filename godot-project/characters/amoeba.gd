extends RigidBody2D

@export var initial_speed_min: float = 20
@export var initial_speed_max: float = 50
@export var edible_value: float = 1

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	var initial_speed = rng.randf_range(initial_speed_min, initial_speed_max)
	var initial_direction = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1)).normalized()
	set_linear_velocity(initial_direction * initial_speed)


func get_value() -> float:
	return edible_value
