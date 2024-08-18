class_name ClickableObject
extends Node3D

signal clicked()


# func _ready():
	# Find all CollisionObject3D children
	# var colliders := find_children("*", "CollisionObject3D")
	# print(colliders)
	# # Wire them up to the on_input_detected event
	# for collider_node in colliders:
	# 	var collider = collider_node as CollisionObject3D
	# 	collider.input_event.connect(on_input_detected)


func on_clicked():
	clicked.emit()