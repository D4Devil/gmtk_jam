extends Node3D

signal clicked(camera: Node, input_event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int)


func _ready():
	# Find all CollisionObject3D children
	var colliders := find_children("*", "CollisionObject3D")
	print(colliders)
	# Wire them up to the on_input_detected event
	for collider_node in colliders:
		var collider = collider_node as CollisionObject3D
		collider.input_event.connect(on_input_detected)


func on_input_detected(camera: Node, input_event: InputEvent, pos: Vector3, normal: Vector3, shape_idx: int):
	print("input received")
	clicked.emit(camera, input_event, pos, normal, shape_idx)
