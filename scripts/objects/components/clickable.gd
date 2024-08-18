class_name Clickable
extends Node3D

signal clicked()


func _ready():
	# Find all CollisionObject3D children
	var colliders := find_children("*", "CollisionObject3D", false)

	for collider in colliders:
		## Sneaky one?, may be even a bug?
		assert(collider is  CollisionObject3D)
		collider.collision_layer = 2


func on_clicked():
	clicked.emit()
