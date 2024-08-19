extends Camera3D

@export var plant_node: Node3D
@export var camera_target_path: String

var target_node: Node3D

func _ready():
	target_node = plant_node.get_node(camera_target_path)
	assert(target_node != null, "Camera target not found!")

func _process(_delta):
	position = target_node.global_position
	rotation = target_node.rotation
