class_name Shovel
extends RigidBody3D


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
		_current_poo.freeze = false
		_current_poo.reparent(owner)
		_current_poo = null

	if not _in_manure or not use:
		return

	## Scoop some poo
	var poo = poo_scene.instantiate() as NutrientParticle
	add_child(poo)
	poo.freeze = true
	_current_poo = poo


func _physics_process(delta: float) -> void:
	if _current_poo:
		_current_poo.transform = anchor.transform


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
