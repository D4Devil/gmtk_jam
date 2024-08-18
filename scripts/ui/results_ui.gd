extends Control

## Categories must be ordered from smallest size to largest size
@export var categories: Array[GradingCategory]

func _on_restart_button_pressed():
	GameStateMachine.on_results_finished()