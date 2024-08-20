class_name Shovel
extends RigidBody3D


var _in_manure := false


signal manure_area(entered: bool, position: Vector3)
signal manure(entered: bool)


func _init():
	contact_monitor = true
	max_contacts_reported = 5


func on_used(use: bool) -> void:
	print("in manure: %s" %_in_manure)
	if not _in_manure or not use:
		return
	
	## Scoop some poo
	print('Used in manure')


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
