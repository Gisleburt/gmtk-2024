extends Node2D

enum Phase {People, Small, Medium, Large}

var phase: Phase = Phase.People
var max_people: int = 20
var people_to_eat: int = 50
var people_eaten: int = 0
var rng = RandomNumberGenerator.new()

var finished = false

func _ready() -> void:
	var door = get_tree().get_nodes_in_group("Door")[6]
	var person = door.open()
	$People.add_child(person)
	person.global_position = door.global_position


func random_door() -> Door:
	var doors = get_tree().get_nodes_in_group("Door")
	var n_children = doors.size()
	if n_children > 0:
		return doors[randi_range(0, n_children - 1)]
	return null


func add_person() -> void:
	if $People.get_child_count() < max_people:
		var door = random_door()
		if door:
			var person = door.open()
			$People.add_child(person)
			person.global_position = door.global_position


func check_phase():
	match phase:
		Phase.People:
			if people_eaten >= people_to_eat:
				phase = Phase.Small
				print(phase)
				for person: Person in $People.get_children():
					person.set_collision_layer_value(4, false)
				for building: Building in get_tree().get_nodes_in_group("BuildingSmall"):
					building.set_collision_layer_value(4, true)
				move_child($TheBlatCity, 0)
		Phase.Small:
			if get_tree().get_nodes_in_group("BuildingSmall").size() <= 0:
				phase = Phase.Medium
				print(phase)
				for building: Building in get_tree().get_nodes_in_group("BuildingMedium"):
					building.set_collision_layer_value(4, true)
		Phase.Medium:
			if get_tree().get_nodes_in_group("BuildingMedium").size() <= 0:
				phase = Phase.Large
				print(phase)
				for building: Building in get_tree().get_nodes_in_group("BuildingLarge"):
					building.set_collision_layer_value(4, true)
		Phase.Large:
			if get_tree().get_nodes_in_group("BuildingLarge").size() <= 0:
				if !finished:
					finished = true
					get_tree().change_scene_to_file("res://levels/stellar.tscn")


func _process(delta: float) -> void:
	add_person()
	check_phase()


func _on_the_blat_city_ate_person() -> void:
	people_eaten += 1
	print(people_eaten)
	$TheBlatCity.scale += Vector2(0.02, 0.02)


func _on_the_blat_city_ate_building() -> void:
	$TheBlatCity.scale += Vector2(0.1, 0.1)
