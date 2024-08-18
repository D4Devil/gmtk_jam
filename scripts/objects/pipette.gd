class_name Pipette
extends Pickable

@export var watering_power: float = 1
@export_flags("Pipette:16") var drag_collision_layer := 16
@export var magic_speed_number := 10.0
@onready var droplet_scene := preload("res://scenes/objects/droplet.tscn")
@onready var drag_agent := $DragAgent

func _ready() -> void:
	super._ready()
	drag_agent.plane_mask = drag_collision_layer
	drag_agent.enable = false

func on_clickable_selected(_collision: Dictionary) -> void:
	super.on_clickable_selected(_collision)
	drag_agent.enable = true


func on_clickable_dropped() -> void:
	super.on_clickable_dropped()
	drag_agent.enable = false
	apply_impulse(drag_agent.velocity)


func on_clickable_use(using: bool) -> void:
	if using:
		var droplet := droplet_scene.instantiate() as PhysicsBody3D
		get_parent().add_child(droplet)
		droplet.add_collision_exception_with(self)
		droplet.initial_speed = drag_agent.velocity * magic_speed_number
		droplet.global_position = global_position
