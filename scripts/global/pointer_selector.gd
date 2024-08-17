class_name Pointer
extends Node3D

const ON_OBJECT_CLICKED := "on_object_clicked"
const ON_OBJECT_DROPPED := "on_object_dropped"

## Cached object
var last_object_clicked: Node3D

signal object_clicked(collision: Dictionary)
signal object_dropped()


func _init() -> void:
	PhysicsServer3D.set_active(true)


func _unhandled_input(event: InputEvent) -> void:
	## Guard against anything but the mouse buttons 
	if not event is InputEventMouseButton:
		return

	if event.is_action_pressed("in_game_select"):
		select_world_object()
		return

	if event.is_action_pressed("in_game_drop"):
		drop_world_object()
		return
		

func select_world_object() -> void:
	var collision_result : Dictionary = Utils.screen_to_3d_object(self)

	## Unload last object from signal
	if last_object_clicked && last_object_clicked.has_method(ON_OBJECT_CLICKED):
		object_clicked.disconnect(last_object_clicked.on_object_clicked)

	## Process the current selected object
	if collision_result.has("collider"):
		var cached_collider = collision_result["collider"] as Node3D

		if cached_collider == last_object_clicked:
			return

		last_object_clicked = cached_collider

		## Wire the clickable interface
		if last_object_clicked.has_method(ON_OBJECT_CLICKED):
			object_clicked.connect(last_object_clicked.on_object_clicked)
			emit_signal("object_clicked", collision_result)

		if last_object_clicked.has_method(ON_OBJECT_DROPPED):
			object_dropped.connect(last_object_clicked.on_object_dropped)


func drop_world_object() -> void:
	emit_signal("object_dropped")

	## Unwire the clickable interface
	object_clicked.disconnect(last_object_clicked.on_object_clicked)
	object_dropped.disconnect(last_object_clicked.on_object_dropped)

	last_object_clicked = null
