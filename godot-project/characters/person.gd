extends StaticBody2D

class_name Person

enum Direction {Left = -1, Right = 1}
enum Moving {Stopped = 0, Moving = 1}

@export var speed: float = 40

var rng = RandomNumberGenerator.new();
@onready var chosen_child: AnimatedSprite2D = $People.get_child(randi_range(0, get_child_count() - 1))
@onready var direction: Direction = [Direction.Left, Direction.Right].pick_random()
@onready var moving: Moving = Moving.Moving


func _ready() -> void:
	chosen_child.visible = true
	set_direction(direction) # use initial direction to start playing right anim

func _process(delta: float) -> void:
	var move = speed * moving * delta
	global_position.x += move * direction
	global_position.y = 0
	
	if did_collide($Left):
		set_direction(Direction.Right)
	if did_collide($Right):
		set_direction(Direction.Left)


func did_collide(area: Area2D) -> bool:
	var bodies = area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("WorldEdge"):
			return true
	return false


func set_direction(dir: Direction) -> void:
	direction = dir
	if direction == Direction.Left:
		chosen_child.play("Left")
	else:
		chosen_child.play("Right")
