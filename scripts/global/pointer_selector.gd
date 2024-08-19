extends Node3D

const CLICKABLE_COLLISION_MASK := 2
const CLICKABLE_ACTION := "in_game_select"

var enabled := true

func _init() -> void:
	PhysicsServer3D.set_active(true)


func _unhandled_input(event: InputEvent) -> void:
	## Guard against anything but the mouse action being clicked
	if not event.is_action_pressed(CLICKABLE_ACTION) or not enabled:
		return
	return

	var collision_result : Dictionary = Utils.screen_to_3d_object(self, CLICKABLE_COLLISION_MASK)
	var bodyClicked: Node = collision_result.get("collider")

	if not bodyClicked:
		return
	
	## Search for parent clickable
	if bodyClicked.get_parent() is Clickable:
		bodyClicked.get_parent().on_clicked()
		return

	## Search for children clickable
	var clickables := bodyClicked.find_children("*", "Clickable", false)
	
	for clickable in clickables:
		assert(clickable is Clickable)
		clickable.on_clicked()
