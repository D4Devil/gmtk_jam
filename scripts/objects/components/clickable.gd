class_name Clickable
extends Node3D

@export var click_action_name := "primary_click" 

signal clicked()


func _ready():
	# Find all CollisionObject3D children
	var colliders := find_children("*", "CollisionObject3D", false)

	for collider in colliders:
		collider = collider as CollisionObject3D
		collider.input_event.connect(input_event)

	if get_parent() is CollisionObject3D:
		get_parent().input_event.connect(input_event)


func input_event( _camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int ) -> void:	
	if event is InputEventMouseButton and event.is_action_pressed(click_action_name):
		on_clicked()


func on_clicked():
	clicked.emit()
