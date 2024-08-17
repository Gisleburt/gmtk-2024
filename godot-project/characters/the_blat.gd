extends CharacterBody2D


@export var speed = 200
@export var friction = 0.01
@export var acceleration = 0.1

var rng = RandomNumberGenerator.new()

var eaten: float = 0;

func get_input():
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	return input

func _physics_process(delta: float) -> void:
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
	else:
		rotate_body(delta)
	
	if $TheBlatBody.has_overlapping_bodies():
		$ClosedMouth.visible = false
		$OpenMouth.visible = true
	else:
		$ClosedMouth.visible = true
		$OpenMouth.visible = false
	


func eat(edible) -> void:
	eaten += edible.get_value()
	print(eaten)
	edible.queue_free()
	var player_idx = rng.randi_range(1, $BiteNoises.get_child_count())
	$BiteNoises.get_child(player_idx - 1).play()
	var scale_add: float = eaten / 10
	scale = Vector2(1 + scale_add, 1 + scale_add)


func rotate_body(_delta: float) -> void:
	var pos = $TheBlatBody/Sprite2D.global_position + get_last_motion().rotated(1.5708)
	if pos.length() == 0:
		pos = $TheBlatBody/Sprite2D.global_position + Vector2.UP
	$TheBlatBody/Sprite2D.look_at(pos)
	#$TheBlatBody/Sprite2D.rotation = lerp_angle($TheBlatBody/Sprite2D.rotation, desired, 1)


func get_eaten() -> int:
	return eaten
