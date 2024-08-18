class_name Pickable
extends RigidBody3D


func _ready() -> void:
	GameStateMachine.state_changed.connect(on_game_state_changed)
	freeze_mode = FREEZE_MODE_KINEMATIC
	freeze = false
	


func on_game_state_changed(_previous: GameStateMachine.GameState, next: GameStateMachine.GameState) -> void:
	if next == GameStateMachine.GameState.GROWTH:
		freeze = false
	else:
		on_clickable_dropped()
        

func on_clickable_selected(_collision: Dictionary) -> void:
	freeze = true


func on_clickable_dropped() -> void:
	freeze = false
