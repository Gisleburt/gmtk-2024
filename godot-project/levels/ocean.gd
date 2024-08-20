extends Node2D

@export var ameoba: PackedScene = preload("res://characters/amoeba.tscn")

@export var initial_enemies: int = 5
@export var max_enemies: int = 20
@export var eaten_goal = 35

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	for i in initial_enemies:
		var point = get_random_point_inside_safe_zone()
		spawn_ameoba(point)


func spawn_ameoba(point: Vector2) -> void:
	var child = ameoba.instantiate() 
	child.global_position = point
	$Enemies.add_child(child)


func spawn_random_ameoba() -> void:
		var point = get_random_point_outside_safe_zone()
		spawn_ameoba(point)


func _process(_delta: float) -> void:
	# Move the spawn paths with the Blat
	$SpawnPaths.global_position = $TheBlat.global_position
	
	# Check for ameoba too far away
	for enemy in $Enemies.get_children():
		if $TheBlat.global_position.distance_to(enemy.global_position) > 900:
			enemy.queue_free()
	
	# Spawn in new ameoba
	if $Enemies.get_child_count() < max_enemies:
		spawn_random_ameoba()
	
	# check win condition
	if $TheBlat.get_num_eaten() >= eaten_goal:
		get_tree().change_scene_to_file("res://levels/city.tscn")


func get_random_point_inside_safe_zone() -> Vector2:
	var progress = rng.randf_range(0.0, 1.0)
	$SpawnPaths/InsideSafeZone/PathFollow2D.progress_ratio = progress
	return $SpawnPaths/InsideSafeZone/PathFollow2D.global_position


func get_random_point_outside_safe_zone() -> Vector2:
	var progress = rng.randf_range(0.0, 1.0)
	$SpawnPaths/OutsideSafeZone/PathFollow2D.progress_ratio = progress
	return $SpawnPaths/OutsideSafeZone/PathFollow2D.global_position


func _on_timer_timeout() -> void:
	$Tutorial.visible = false
