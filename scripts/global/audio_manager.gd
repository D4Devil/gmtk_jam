class_name AudioManager
extends Node3D

static var instance: AudioManager

@export var tap_scene: PackedScene

func _ready():
	instance = self

func tap_at(pos: Vector3):
	var tap_node = tap_scene.instantiate()
	tap_node.position = pos
	add_child(tap_node)