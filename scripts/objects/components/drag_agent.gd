class_name DragAgent
extends Node3D

## Turn the behavior on and off
@export var enable = false:
	set(value):
		if value:
			_clamp_to_plane()
		enable = value


## Collision mask
@export var plane_mask := 0

## Draggable physic object
@export var physics_node: PhysicsBody3D

var move_to := Vector3.ZERO


func _clamp_to_plane():
	pass


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
    ## snapp to the plane
	physics_node.transform.origin = move_to
