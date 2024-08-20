extends Node3D

@export var direction: Vector3
@export var force: float
@export var interval: float

@onready var open_model: Node3D = $OpenModel
@onready var closed_model: Node3D = $ClosedModel
@onready var fert_stream: NutrientStream = $FertStream
@onready var water_stream: NutrientStream = $WaterStream
var is_open = false


func _ready():
	open_model.visible = false
	closed_model.visible = true


func on_click():
	open_model.visible = true
	closed_model.visible = false
	is_open = true
	fert_stream.interval = interval
	fert_stream.launch_force = direction.normalized() * force
	fert_stream.toggle()
	water_stream.interval = interval
	water_stream.launch_force = direction.normalized() * force
	water_stream.toggle()