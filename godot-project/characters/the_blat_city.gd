extends CharacterBody2D

signal ate_person
signal ate_building

@export var speed: float = 200
@export var friction: float = 0.01
@export var acceleration: float = 0.1
@export var gravity: float = 100

var rng = RandomNumberGenerator.new()


func get_input():
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	return input


func _physics_process(delta: float) -> void:
	velocity.y += delta * gravity
	
	var direction = get_input()
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()
	
	# if else used to prevent rotate when colliding
	if get_slide_collision_count() > 0:
		for collision_idx in get_slide_collision_count():
			var collider = get_slide_collision(collision_idx).get_collider()
			if collider and collider.is_in_group("Edible"):
				eat(collider)
	
	# Mouth Open or Closed
	$OpenMouth.visible = $TheBlatBody.has_overlapping_bodies()
	$ClosedMouth.visible = !$TheBlatBody.has_overlapping_bodies()


func eat(edible: Node2D) -> void:
	var player_idx = rng.randi_range(1, $BiteNoises.get_child_count())
	$BiteNoises.get_child(player_idx - 1).play()
	
	if edible.is_in_group("Person"):
		ate_person.emit()
	if edible.is_in_group("BuildingLarge") ||  edible.is_in_group("BuildingMedium") ||  edible.is_in_group("BuildingSmall"):
		ate_building.emit()
	edible.queue_free()
