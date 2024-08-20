class_name WaterStreamer
extends Node3D

@export var nutrient_volume: float
@export var nutrient_type: Nutrient.Nutrients
@export var launch_force: Vector2


@onready var water_stream: Sprinkler = $WaterStream


func _ready():
	var nutrient = Nutrient.new(nutrient_type, nutrient_volume)
	print("My nutrient is null?", nutrient == null)
	water_stream.nutrient = nutrient
	water_stream.launch_force = launch_force

func on_clicked():
	water_stream._enabled = not water_stream._enabled