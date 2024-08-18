extends Control

## Categories must be ordered from smallest size to largest size
@export var categories: Array[GradingCategory]

## How many places (participants) are there in the category
@export var participants_per_category: int

func _ready():
	GradingManager.categories = categories
	GradingManager.participants_per_category = participants_per_category
	GradingManager.size_graded.connect(refresh_grading)

func _on_restart_button_pressed():
	GameStateMachine.on_results_finished()
		

## TODO: Update all the UI for displaying the category and place
func refresh_grading():
	pass