class_name Droplet
extends RigidBody3D

@export var nutrient : Nutrient
@onready var nut_source := preload("res://scripts/resources/nutrient.gd")

var _initial_speed : Vector3
var _initial_flag := true


signal landed_on_kale()

func _init() -> void:
	contact_monitor = true
	max_contacts_reported = 1


func configure(initial_speed: Vector3, origin: Node3D, collision_exception: PhysicsBody3D = null, nutrient_value = 0.2, nutrient_type := Nutrient.Nutrients.Water):
	if not nutrient:
		nutrient = nut_source.new(nutrient_type, nutrient_value)

	_initial_speed = initial_speed

	if not collision_exception:
		collision_exception = origin
	add_collision_exception_with(collision_exception)
	global_position = origin.global_position


func _physics_process(_delta):
	if _initial_flag:
		apply_central_impulse(_initial_speed)
		_initial_flag = false


func _on_body_entered(body: Node):
	if get_collision_exceptions().has(body):
		return

	if body.get_groups().has("Kale"):
		nutrient.on_applyed()
		landed_on_kale.emit()
	queue_free()
