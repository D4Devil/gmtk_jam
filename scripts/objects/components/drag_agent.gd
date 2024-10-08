class_name DragAgent
extends Node3D


@export var speed: float = 10
@export var draged_emition_threshold := 0.2
@export var target : Node3D
@export var up := Vector3.UP

## Collision mask
@export_flags("Closest:16","Floor:8", "ShovelPlane:4096") var plane_mask := 0
@export var root: Node3D

var enable = false : set = set_enable

## Cached Values
var _move_to := Vector3.ZERO
var _velocity = Vector3.ZERO: get = get_velocity
var _target_pos := Vector3.ZERO


signal draged(velocity: Vector3, origin: Vector3)


func _process(delta: float) -> void:
	if not enable:
		return

	var collisions = Utils.screen_to_3d_object(self, plane_mask)
	if collisions.has("collider"):
		_move_to = collisions["position"]

	if target:
		_target_pos = target.global_position

	root.look_at(_target_pos, up)
	_velocity = _sqrt_interpolation(delta)

	if _velocity.length() >= draged_emition_threshold:
		draged.emit(_velocity, root.transform.origin)
	root.transform.origin += _velocity * speed


func _sqrt_interpolation(delta) -> Vector3:
	return root.global_position.direction_to(_move_to) * root.global_position.distance_squared_to(_move_to) * delta
	

func set_enable(value: bool) -> void:
	enable = value


func get_velocity() -> Vector3:
	return _velocity


func set_target(entered: bool, node: Node3D) -> void:
	if entered:
		target = node
	else:
		target = null
		_target_pos = Vector3.ZERO
