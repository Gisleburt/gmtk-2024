extends Node2D


var max_people: int = 20
var rng = RandomNumberGenerator.new()


func _ready() -> void:
	var door = get_tree().get_nodes_in_group("Door")[6]
	var person = door.open()
	$People.add_child(person)
	person.global_position = door.global_position
	pass


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


func _process(delta: float) -> void:
	add_person()
