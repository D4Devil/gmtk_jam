extends Node3D

## A plant size value when the model should switch from
## seedling to fully grown.
@export var full_grown_size: float = 1.0

@onready var anim_player: AnimationPlayer = $AnimationPlayer

@onready var plant_collider:= $StaticBody3D
## Is the plant fully grown. Keeps track if the full grown animation has played yet.
var is_full: bool = false


func _process(_delta):
	scale = Vector3.ONE * PlantStats.size
	plant_collider.get_child(0).shape.radius = PlantStats.size
	if not is_full and scale.x >= full_grown_size:
		is_full = true
		anim_player.play("grow_full")


func start():
	anim_player.play("start")
