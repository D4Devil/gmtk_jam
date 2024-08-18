class_name Droplet
extends RigidBody3D

@export var nutrient_value: float
@onready var nutrient := $KaleNutrient
var initial_speed : Vector3
var initial_flag := true

func _init(nut_val: float = 0.2) -> void:
	## So its not detected by anyone
	collision_layer = 0
	input_ray_pickable = false
	max_contacts_reported = 1
	nutrient_value = nut_val
	contact_monitor = true


func _ready():
	nutrient.nutrient_volume = nutrient_value


func _physics_process(_delta):
	if initial_flag:
		apply_central_impulse(initial_speed)
		initial_flag = false


func _on_body_entered(body: Node):
	if body.get_groups().has("Kale"):
		nutrient.apply()
	
	queue_free()
