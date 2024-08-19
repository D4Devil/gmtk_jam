class_name Plant
extends Node3D

static var plant_center: Vector3

@onready var plant_center_marker: Marker3D = $PlantCenter

## A plant size value when the model should switch from
## seedling to fully grown.
@export var full_grown_size: float = 1.0

@onready var anim_player: AnimationPlayer = $AnimationPlayer

## Is the plant fully grown. Keeps track if the full grown animation has played yet.
var is_full: bool = false


func _process(_delta):
	scale = Vector3.ONE * PlantStats.size
	plant_center = plant_center_marker.global_position
	if not is_full and scale.x >= full_grown_size:
		is_full = true
		anim_player.play("grow_full")


func start():
	anim_player.play("start")
