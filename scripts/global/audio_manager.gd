class_name AudioManager
extends Node3D

static var instance: AudioManager

@export var tap_scene: PackedScene
@export var wind_per_size: Curve

@onready var wind: AudioStreamPlayer = $Wind

func _ready():
	instance = self

func _process(delta):
	wind.volume_db = wind_per_size.sample(PlantStats.size_sample_value)

func tap_at(pos: Vector3):
	var tap_node = tap_scene.instantiate()
	tap_node.position = pos
	add_child(tap_node)
