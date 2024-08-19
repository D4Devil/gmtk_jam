class_name GrowthRayTower
extends Node3D

@onready var dish: Node3D = $growth_dish
@onready var ray: MeshInstance3D = $growth_dish/Ray

var is_pointing_at_plant := false
var is_power_on = false

var target_rotation: float = -10

func _ready():
	dish.rotation.x = -TAU / 2

func _process(delta):
	if is_pointing_at_plant:
		dish.look_at(Plant.plant_center, Vector3.UP, true)
	ray.rotation.z += TAU * delta

func on_dish_clicked():
	is_pointing_at_plant = true
	PlantStats.is_growth_ray_enabled = is_pointing_at_plant and is_power_on

func on_power_on():
	ray.visible = true
	is_power_on = true
	PlantStats.is_growth_ray_enabled = is_pointing_at_plant and is_power_on