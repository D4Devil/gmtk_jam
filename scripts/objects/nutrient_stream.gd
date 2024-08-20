class_name NutrientStream
extends Node3D

@export var enabled := false
@export var nutrient_volume: float
@export var nutrient_type: Nutrient.Nutrients
@export var launch_force: Vector3
@export var force_variation_mult: float
@export var interval: float
@export var nutrient_scene: PackedScene

@onready var dir_marker: Marker3D = $Direction
@onready var shoot_timer: Timer = $ShootTimer

func _ready():
	if enabled:
		shoot_timer.start(interval)

func toggle():
	enabled = not enabled
	if enabled:
		shoot_timer.start(interval)
	else:
		shoot_timer.stop()

func shoot():
	print("Shoooot!")
	#var dir = dir_marker.get_global_transform().basis.z
	var force = launch_force + (Utils.rand_pos_in_sphere()*launch_force*force_variation_mult)
	var droplet = nutrient_scene.instantiate() as NutrientParticle
	get_tree().root.add_child(droplet)
	droplet.configure(force, dir_marker, null, nutrient_volume, nutrient_type)
