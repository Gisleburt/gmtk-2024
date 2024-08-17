extends Node2D

@export var play_range: float = 1_250.0

var rng = RandomNumberGenerator.new()

func get_random_point_inside_safe_zone() -> Vector2:
	var progress = rng.randf_range(0.0, 1.0)
	$TheBlatController/Camera2D/InsideSafeZone/PathFollow2D.progress_ratio = progress
	return $TheBlatController/Camera2D/InsideSafeZone/PathFollow2D.global_position


func get_random_point_outside_safe_zone() -> Vector2:
	var progress = rng.randf_range(0.0, 1.0)
	$TheBlatController/Camera2D/OutsideSafeZone/PathFollow2D.progress_ratio = progress
	return $TheBlatController/Camera2D/OutsideSafeZone/PathFollow2D.global_position


func is_out_of_play_range(check_pos: Vector2) -> bool:
	return $TheBlatController.global_position.distance_to(check_pos) > play_range
