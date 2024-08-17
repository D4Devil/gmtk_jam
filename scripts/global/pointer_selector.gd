extends Node3D

const ON_CLICKABLE_SELECTED := "on_clickable_selected"
const ON_CLICKABLE_DROPPED := "on_clickable_dropped"
const ON_USING_CLICKABLE := "on_clickable_use"

const CLICKABLE_COLLISION_MASK := 2

## Cached object
var last_object_clicked: Node3D

signal object_clicked(collision: Dictionary)
signal clickable_use(using: bool)
signal object_dropped()


func _init() -> void:
	PhysicsServer3D.set_active(true)


func _unhandled_input(event: InputEvent) -> void:
	## Guard against anything but the mouse buttons 
	if event is not InputEventMouseButton:
		return

	if event.is_action_pressed("in_game_select"):
		if last_object_clicked:
			start_using_clickable()
		else:
			get_clickable()
		return

	if event.is_action_released("in_game_select") and last_object_clicked:
		stop_using_clickable()

	if event.is_action_pressed("in_game_drop"):
		drop_clickable()
		return


## Try to select an object at current's mouse position.
func get_clickable() -> void:
	var collision_result : Dictionary = Utils.screen_to_3d_object(self, CLICKABLE_COLLISION_MASK)

	## Unload last object from signal
	if last_object_clicked && last_object_clicked.has_method(ON_CLICKABLE_SELECTED):
		object_clicked.disconnect(last_object_clicked.on_object_clicked)

	## Process the current selected object
	if collision_result.has("collider"):
		var cached_collider = collision_result["collider"] as Node3D

		if cached_collider == last_object_clicked:
			return

		last_object_clicked = cached_collider
		wire_clickable()

		if object_clicked:
			emit_signal("object_clicked", collision_result)


func wire_clickable():
	if last_object_clicked.has_method(ON_CLICKABLE_SELECTED):
		object_clicked.connect(last_object_clicked.on_clickable_selected)
		
	if last_object_clicked.has_method(ON_USING_CLICKABLE):
		clickable_use.connect(last_object_clicked.on_clickable_use)

	if last_object_clicked.has_method(ON_CLICKABLE_DROPPED):
		object_dropped.connect(last_object_clicked.on_clickable_dropped)


func drop_clickable() -> void:
	## Guard against null
	if not last_object_clicked:
		return

	emit_signal("object_dropped")
	unwire_clickable()
	last_object_clicked = null


func unwire_clickable():
	if last_object_clicked.has_method(ON_CLICKABLE_SELECTED):
		object_clicked.disconnect(last_object_clicked.on_clickable_selected)

	if last_object_clicked.has_method(ON_USING_CLICKABLE):
		clickable_use.disconnect(last_object_clicked.on_clickable_use)

	if last_object_clicked.has_method(ON_CLICKABLE_DROPPED):
		object_dropped.disconnect(last_object_clicked.on_clickable_dropped)


func start_using_clickable():
	if not clickable_use:
		return
	
	emit_signal("clickable_use", true)


func stop_using_clickable():
	if not clickable_use:
		return
	
	emit_signal("clickable_use", false)
