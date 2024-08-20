extends Node3D

@export var radius: float
@export var houses_count: int
@onready var house_scene: PackedScene = preload("res://scenes/props/flat_house.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in houses_count:
		var house = house_scene.instantiate() as Sprite3D
		house.position = Vector3(randf_range(-radius, radius), 0.0, randf_range(-radius, radius))
		house.modulate = Color8(randi_range(190, 240), randi_range(190, 240), randi_range(190, 240))
		add_child(house)