extends Node2D

@export var ameoba: PackedScene = preload("res://characters/amoeba.tscn")

@export var initial_enemies: int = 5;
@export var max_enemies: int = 20;

func _ready() -> void:
	for i in initial_enemies:
		var point = $TheBlat.get_random_point_inside_safe_zone()
		spawn_ameoba(point)


func spawn_ameoba(point: Vector2) -> void:
	var child = ameoba.instantiate()
	child.global_position = point
	
	$Enemies.add_child(child)


func spawn_random_ameoba() -> void:
		var point = $TheBlat.get_random_point_outside_safe_zone()
		spawn_ameoba(point)


func _process(_delta: float) -> void:
	# Check for ameoba too far away
	for enemy in $Enemies.get_children():
		if $TheBlat.is_out_of_play_range(enemy.global_position):
			enemy.queue_free()
	
	# Spawn in new ameoba
	if $Enemies.get_child_count() < max_enemies:
		spawn_random_ameoba()
