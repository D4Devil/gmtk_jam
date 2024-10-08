class_name Pipette
extends Node3D

## Dependency
@export var physic_body : PhysicsBody3D

@export var watering_power: float = 1
@export var magic_speed_number := 100.0
@onready var droplet_scene := preload("res://scenes/objects/droplet.tscn")
@onready var droplet_audio: AudioStreamPlayer3D = $DropletAudio

var _velocity := Vector3.ZERO


func on_used(using: bool) -> void:
	if using:
		var droplet := droplet_scene.instantiate() as NutrientParticle
		assert(physic_body != null)
		physic_body.get_parent().add_child(droplet)
		droplet.configure(_velocity * magic_speed_number, physic_body, null, watering_power, Nutrient.Nutrients.Water)
		droplet_audio.play()


func _on_draged(velocity:Vector3, _origin:Vector3) -> void:
	_velocity = velocity

## Move this to DragAgent
func _on_droped():
	(physic_body as RigidBody3D).apply_central_impulse(_velocity * _velocity.length())
