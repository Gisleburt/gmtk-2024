extends CharacterBody2D

class_name Person

enum Direction {Left = -1, Right = 1}
enum Moving {Stopped = 0, Moving = 1}

@export var speed: float = .3

var rng = RandomNumberGenerator.new();
@onready var chosen_child: AnimatedSprite2D = $People.get_child(randi_range(0, get_child_count() - 1))
@onready var direction: Direction = [Direction.Left, Direction.Right].pick_random()
@onready var moving: Moving = [Moving.Stopped, Moving.Moving].pick_random()


func _ready() -> void:
	chosen_child.visible = true
	set_direction(direction) # use initial direction to start playing right anim


func _process(delta: float) -> void:
	velocity.y = 0
	velocity.x = speed * direction * moving
	var collision = move_and_collide(velocity * delta)
	if collision:
		direction *= -1


func set_direction(dir: Direction) -> void:
	direction = dir
	if dir == Direction.Left:
		chosen_child.play("Left")
	else:
		chosen_child.play("Right")
