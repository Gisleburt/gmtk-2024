extends CharacterBody2D

signal win_condition_eaten
signal scale_change(change:float, new_scale: float)

@export var speed = 200
@export var friction = 0.01
@export var acceleration = 0.1

var rng = RandomNumberGenerator.new()

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
			if collider and collider.is_in_group("Edible") and can_eat(collider):
				if collider.is_in_group("WinCondition"):
					win_condition_eaten.emit()
				eat(collider)
	else:
		rotate_body(delta)
	
	# Mouth Open or Closed
	$OpenMouth.visible = $TheBlatBody.has_overlapping_bodies()
	$ClosedMouth.visible = !$TheBlatBody.has_overlapping_bodies()


func can_eat(node: Node2D) -> bool:
	return node.scale < scale


func eat(edible) -> void:
	edible.queue_free()
	var player_idx = rng.randi_range(1, $BiteNoises.get_child_count())
	$BiteNoises.get_child(player_idx - 1).play()
	var change = edible.scale * 0.4
	scale += change
	scale_change.emit(change, scale.x)


func rotate_body(_delta: float) -> void:
	var pos = $TheBlatBody/Sprite2D.global_position + get_last_motion().rotated(1.5708)
	if pos.length() == 0:
		pos = $TheBlatBody/Sprite2D.global_position + Vector2.UP
	$TheBlatBody/Sprite2D.look_at(pos)
	#$TheBlatBody/Sprite2D.rotation = lerp_angle($TheBlatBody/Sprite2D.rotation, desired, 1)
