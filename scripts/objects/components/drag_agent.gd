class_name DragAgent
extends Node3D

## Turn the behavior on and off
var enable := false

@export var speed: float = 10

## Collision mask
@export_flags("Pipette:16") var plane_mask := 0

## Draggable physic object
@export var physics_node: PhysicsBody3D

## New position for the object
var move_to := Vector3.ZERO
var velocity := Vector3.ZERO


func _unhandled_input(event: InputEvent) -> void:
	## Guard against events unless is mouse motion
	if event is not InputEventMouseMotion or not enable:
		return

	## NOTE:: This event is only triggered when the mouse moves
	event = event as InputEventMouseMotion
	var collisions = Utils.screen_to_3d_object(self, plane_mask)
	if collisions.has("collider"):
		move_to = collisions["position"]


func _process(delta: float) -> void:
	if not enable:
		return

	physics_node.look_at(Vector3.ZERO)
	velocity = _sqrt_interpolation(delta) * speed
	physics_node.transform.origin += velocity


func _sqrt_interpolation(delta) -> Vector3:
	return physics_node.global_position.direction_to(move_to) * physics_node.global_position.distance_squared_to(move_to) * delta
	
