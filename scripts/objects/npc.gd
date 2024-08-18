extends Node3D
## Spawns a random NPC model

@export var character_scenes: Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready():
	var character_inx = randi_range(0, character_scenes.size() - 1)
	var picked_scene = character_scenes[character_inx]
	var character_node = picked_scene.instantiate() as Node3D
	add_child(character_node)
	character_node.position += Vector3(randf_range(-0.1, 0.1), 0, randf_range(-0.1, 0.1))
	character_node.rotate_y(randf_range(-8, 8)/180)