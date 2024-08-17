class_name Pointer
extends Node3D

const ON_OBJECT_CLICKED := "on_object_clicked"

## Cached object
var last_object_clicked: Node3D

signal object_clicked(collision: Dictionary)


func _init() -> void:
	PhysicsServer3D.set_active(true)


func _unhandled_input(event: InputEvent) -> void:
	## Guard against anything but the mouse buttons 
	if event is InputEventMouseButton:
		return

	if event.is_action_pressed("in_game_select"):
		select_world_object()
		
        

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

		if last_object_clicked.has_method(ON_OBJECT_CLICKED):
			object_clicked.connect(last_object_clicked.on_object_clicked)
			emit_signal("object_clicked", collision_result)
