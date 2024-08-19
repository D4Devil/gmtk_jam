class_name WaterStreamer
extends Node3D

#Dependency
@export var water_origin : Node3D
@export var stream_target : Node3D


@export_category("Tuning")
## Not very elegant, but min and max for the force applied to the water
@export var launch_force := Vector2.ZERO
@export_range(5.0, 90.0) var arch_in_degrees := 20.0
@export var arch_deviation : float
@export var tilt_deviation : float
@export var firing_rate : float
@export var firing_deviation : float

@onready var droplet_scene := preload("res://scenes/objects/droplet.tscn")

var _enabled := true
var _current_arch: float = 0
var _fired_delta: float = 0


func _process(delta):
	_fired_delta += delta + randf_range(-firing_deviation, firing_deviation)
	_current_arch += delta

	if _current_arch >= arch_in_degrees /2.0:
		_current_arch = -arch_in_degrees / 2.0
	
	if not _enabled or _fired_delta < firing_rate:
		return
	## Reset fire cooldown
	_fired_delta = 0

	## Get all the deviations
	var force_v = randf_range(launch_force.x, launch_force.y) 
	var arch_v = randf_range(-arch_deviation, arch_deviation) + _current_arch
	var tilt_v = randf_range(-tilt_deviation, tilt_deviation)

	var dir = water_origin.global_position.direction_to(stream_target.global_position)
	dir = dir.rotated(Vector3.RIGHT, deg_to_rad(tilt_v)).rotated(Vector3.UP, deg_to_rad(arch_v)) * 1000
	dir = dir.limit_length(force_v)

	var droplet = droplet_scene.instantiate() as Droplet
	owner.add_child(droplet)
	droplet.configure(dir, water_origin)


func _on_enabled() -> void:
	_enabled = !_enabled
