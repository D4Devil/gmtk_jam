extends Node

enum GameState {MAIN_MENU, GROWTH, RESULTS}

var state: GameState = GameState.MAIN_MENU

signal state_changed(old_state: GameState, new_state: GameState)

func _on_new_game_started():
	if state != GameState.MAIN_MENU:
		push_error("Tried to start new game while not in the main menu")
		return
	
	print("Moving from MAIN_MENU to GROWTH state")
	state = GameState.GROWTH
	state_changed.emit(GameState.MAIN_MENU, state)

func _on_growth_finished():
	if state != GameState.GROWTH:
		push_error("Tried to finish growth while not in the growth stage")
		return
	
	print("Moving from GROWTH to RESULTS state")
	state = GameState.RESULTS
	state_changed.emit(GameState.GROWTH, state)

func _on_results_finished():
	if state != GameState.RESULTS:
		push_error("Tried to finish results while not in the results stage")
		return
	
	print("Moving from RESULTS to GROWTH state")
	state = GameState.GROWTH
	state_changed.emit(GameState.RESULTS, state)

func _on_stop_game():
	if state == GameState.MAIN_MENU:
		push_error("Tried to finish playing while not main menu")
		return
	
	print("Moving to MAIN_MENU state")
	var prev_state = state
	state = GameState.MAIN_MENU
	state_changed.emit(prev_state, state)