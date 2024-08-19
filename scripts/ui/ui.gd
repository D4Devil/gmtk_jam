extends CanvasLayer

@onready var main_menu: Control = $MainMenu
@onready var plant_stats_ui: Control = $PlantStatsUi
@onready var plant_stat_changes_ui: Control = $PlantStatChangesUI
@onready var results_ui: Control = $ResultsUI

func _ready():
	GameStateMachine.state_changed.connect(on_game_state_changed)


func on_game_state_changed(old_state: GameStateMachine.GameState, new_state: GameStateMachine.GameState):
	# MAIN MENU

	if old_state == GameStateMachine.GameState.MAIN_MENU:
		main_menu.visible = false

	if new_state == GameStateMachine.GameState.MAIN_MENU:
		main_menu.visible = true

	# GROWTH

	if old_state == GameStateMachine.GameState.GROWTH:
		plant_stats_ui.visible = false
		plant_stat_changes_ui.visible = false
		plant_stat_changes_ui.stop()

	if new_state == GameStateMachine.GameState.GROWTH:
		plant_stats_ui.visible = true
		plant_stat_changes_ui.reset()
		plant_stat_changes_ui.visible = true

	# RESULTS

	if old_state == GameStateMachine.GameState.RESULTS:
		results_ui.visible = false

	
	if new_state == GameStateMachine.GameState.RESULTS:
		results_ui.visible = true
