extends Node3D

@onready var open_model: Node3D = $OpenModel
@onready var closed_model: Node3D = $ClosedModel

var is_open = false


func _ready():
	open_model.visible = false
	closed_model.visible = true


func on_click():
	open_model.visible = true
	closed_model.visible = false
	is_open = true