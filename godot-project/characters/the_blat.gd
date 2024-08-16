extends Node2D

@export var stiffness = 64

func _ready() -> void:
	var springs = findSprings(self)
	print(springs.size())
	for spring in springs:
		spring.stiffness = stiffness


func  _physics_process(delta):
	for i in 9:
		print("Bone2D_" + str(i))
		print("RigidBody2D_" + str(i))
		get_node("Skeleton2D/Bone2D_" + str(i)).global_position = get_node("RigidBody2D_" + str(i)).global_position


func findSprings(node: Node) -> Array[DampedSpringJoint2D]:
	var result: Array[DampedSpringJoint2D] = []
	if node.is_class("DampedSpringJoint2D") :
		result.push_back(node)
	for child in node.get_children():
		result.append_array(findSprings(child))
	return result
