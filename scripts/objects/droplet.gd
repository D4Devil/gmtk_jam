class_name Droplet
extends RigidBody3D

@export var nutrient_value: float
@onready var nutrient := $KaleNutrient

func _init(nut_val: float = 0.2) -> void:
	## So its not detected by anyone
	collision_layer = 0
	input_ray_pickable = false
	max_contacts_reported = 1
	nutrient_value = nut_val
	contact_monitor = true


func _ready():
	nutrient.nutrient_volume = nutrient_value


func drop(starting_force: Vector3 = Vector3.ZERO):
	linear_velocity = starting_force


func _on_body_entered(body: Node):
	if body.get_groups().has("Kale"):
		nutrient.apply()
	
	queue_free()
