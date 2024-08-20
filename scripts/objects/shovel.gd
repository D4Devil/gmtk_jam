class_name Shovel
extends RigidBody3D

@export var fertilization_value : float = 2

@onready var poo_scene = preload("res://scenes/objects/poo_scoop.tscn")
@onready var anchor = $PooAnchor

var _in_manure := false
var _current_poo : NutrientParticle = null

signal manure_area(entered: bool, position: Vector3)
signal manure(entered: bool)


func _init():
	contact_monitor = true
	max_contacts_reported = 5


func on_used(use: bool) -> void:
	if use and _current_poo:
		_current_poo.reparent(get_parent())
		_current_poo.freeze = false
		_current_poo.linear_velocity = linear_velocity
		_current_poo = null

	if not _in_manure or not use:
		return

	var poo = poo_scene.instantiate() as NutrientParticle
	poo.add_collision_exception_with(self)

	## this line throws errors, but, if i remove it then the _current_poo
	## is freed befor checks and that throws exeption, ergo brakes the game
	add_child(poo)
	poo.configure(Vector3.ZERO, self, self, fertilization_value, Nutrient.Nutrients.Fertilizer)
	poo.freeze = true
	_current_poo = poo


func _process(_delta) -> void:
	if _current_poo and not _current_poo.is_queued_for_deletion():
		print(linear_velocity)
		_current_poo.global_basis = anchor.global_basis
		_current_poo.global_position = global_position


func on_body_entered(body: Node) -> void:
	if body is not Area3D:
		return

	if body.get_groups().has("Near_Manure"):
		manure_area.emit(true, body)
		return

	if body.get_groups().has("Manure"):
		_in_manure = true
		manure.emit(true)


func on_body_exited(body: Node) -> void:
	if body is not Area3D:
		return

	if body.get_groups().has("Near_Manure"):
		manure_area.emit(false, body)
		return

	if body.get_groups().has("Manure"):
		_in_manure = false
		manure.emit(false)
