extends CharacterBody2D


@export var speed = 200
@export var friction = 0.01
@export var acceleration = 0.1


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

func _physics_process(_delta: float) -> void:
	var direction = get_input()
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()
	
	for collision_idx in get_slide_collision_count():
		var collision = get_slide_collision(collision_idx)
		if collision.get_collider():
			var parent = collision.get_collider().get_parent()
			if parent.is_in_group("Edible") :
				parent.free()
