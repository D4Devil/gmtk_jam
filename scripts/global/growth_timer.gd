extends Node

## Total time available for growth (in seconds)
@export var total_time: float = 15 #5.0 * 60

var time_left: float = total_time

signal timeout()


func _ready():
	time_left = total_time
	GameStateMachine.state_changed.connect(on_game_state_changed)


func _process(delta):
	time_left -= delta
	if (time_left <= 0.0):
		time_left = 0
		timeout.emit()
		if GameStateMachine.state == GameStateMachine.GameState.GROWTH:
			GameStateMachine.on_growth_finished()


func reset():
	time_left = total_time


func on_game_state_changed(_old_state: GameStateMachine.GameState, new_state: GameStateMachine.GameState):
	if new_state == GameStateMachine.GameState.GROWTH:
		reset()
