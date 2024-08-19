extends Node2D

class_name Door

var packed_person: PackedScene = preload("res://characters/Person.tscn")

@onready var chosen_child: AnimatedSprite2D = get_child(randi_range(0, get_child_count() - 1))

func _ready() -> void:
	chosen_child.visible = true


func open() -> Person:
	chosen_child.play()
	var person: Person = packed_person.instantiate()
	person.global_position = global_position
	return person
