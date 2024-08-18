extends Node3D

## The main gameplay scene with the plant growing and all the tools around it
@export var growth_scene: PackedScene;

## The scene to show the results
@export var results_scene: PackedScene;

@onready var levels: Node3D = $Levels

var growth_level: Node = null
var results_level: Node = null


func _ready():
	GameStateMachine.state_changed.connect(on_game_state_changed)


func on_game_state_changed(
		old_state: GameStateMachine.GameState,
		new_state: GameStateMachine.GameState):
	# When going to MAIN_MENU, unload all levels
	if new_state == GameStateMachine.GameState.MAIN_MENU:
		if growth_level != null:
			growth_level.queue_free()
		if results_level != null:
			results_level.queue_free()

	# GROWTH
	if old_state == GameStateMachine.GameState.GROWTH:
		if growth_level != null:
			growth_level.queue_free()

	if new_state == GameStateMachine.GameState.GROWTH:
		growth_level = growth_scene.instantiate() as Node
		levels.add_child(growth_level)

	# RESULTS
	if old_state == GameStateMachine.GameState.RESULTS:
		if results_level != null:
			results_level.queue_free()

	if new_state == GameStateMachine.GameState.RESULTS:
		results_level = results_scene.instantiate() as Node
		levels.add_child(results_level)