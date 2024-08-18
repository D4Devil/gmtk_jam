class_name Pickable
extends Node

@export var use_action := "in_game_action"
@export var drop_action := "in_game_drop"

var enabled := false

signal picked()
signal used(using: bool)
signal droped()

func on_picked():
	PointerSelector.enabled = false
	enabled = true
	picked.emit()


func on_used(using: bool):
	used.emit(using)


func on_droped():
	PointerSelector.enabled = true
	enabled = false
	droped.emit()


func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventMouseButton or not enabled:
		return

	if event.is_action_pressed(drop_action):
		on_droped()

	if event.is_action_released(use_action):
		on_used(false)

	elif event.is_action(use_action):
		on_used(true)
		
