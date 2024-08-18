extends Node3D
@onready var kale_model: Node3D = $KaleModel

# Called when the node enters the scene tree for the first time.
func _ready():
	kale_model.scale = Vector3.ONE * PlantStats.size
	kale_model.rotate_y(randf_range(-TAU, TAU))