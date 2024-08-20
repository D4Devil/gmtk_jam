extends Node3D

@export var radius: float
@export var trees_count: int
@onready var tree_scene: PackedScene = preload("res://scenes/props/tree.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in trees_count:
		var tree = tree_scene.instantiate() as Sprite3D
		tree.position = Vector3(randf_range(-radius, radius), 0.0, randf_range(-radius, radius))
		tree.pixel_size = randf_range(0.08, 0.17)
		add_child(tree)