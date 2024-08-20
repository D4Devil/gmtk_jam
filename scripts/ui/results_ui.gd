extends Control

## Categories must be ordered from smallest size to largest size
@export var categories: Array[GradingCategory]

## How many places (participants) are there in the category
@export var participants_per_category: int

@onready var grading_display: HBoxContainer = $MarginContainer/GradingDisplay
@onready var category_label: Label = $MarginContainer/GradingDisplay/CategoryLabel
@onready var category_f: TextureRect = $MarginContainer/GradingDisplay/CategoryF
@onready var category_e: TextureRect = $MarginContainer/GradingDisplay/CategoryE
@onready var category_d: TextureRect = $MarginContainer/GradingDisplay/CategoryD
@onready var category_c: TextureRect = $MarginContainer/GradingDisplay/CategoryC
@onready var category_b: TextureRect = $MarginContainer/GradingDisplay/CategoryB
@onready var category_a: TextureRect = $MarginContainer/GradingDisplay/CategoryA
@onready var category_s: TextureRect = $MarginContainer/GradingDisplay/CategoryS
@onready var place_label: Label = $MarginContainer/GradingDisplay/PlaceLabel
@onready var failure_label: Label = $MarginContainer/GradingDisplay/FailureLabel
@onready var plant_size_label: Label = $MarginContainer/GradingDisplay/PlantSizeLabel

func _ready():
	GradingManager.categories = categories
	GradingManager.participants_per_category = participants_per_category
	GradingManager.size_graded.connect(refresh_grading)
	grading_display.visible = false

func _on_restart_button_pressed():
	GameStateMachine.on_results_finished()
		

func refresh_grading():
	var disqualified = GradingManager.is_disqualified
	var category = GradingManager.assigned_category
	var cat_label = "No category" if category == null else category.label

	category_label.visible = not disqualified
	category_f.visible = not disqualified and cat_label == "F"
	category_e.visible = not disqualified and cat_label == "E"
	category_d.visible = not disqualified and cat_label == "D"
	category_c.visible = not disqualified and cat_label == "C"
	category_b.visible = not disqualified and cat_label == "B"
	category_a.visible = not disqualified and cat_label == "A"
	category_s.visible = not disqualified and cat_label == "S"
	place_label.visible = not disqualified
	failure_label.visible = disqualified
	plant_size_label.text = "Kale scale: %.4fx" % PlantStats.size

	if not disqualified:
		place_label.text = \
				"Place: %d" % GradingManager.place_in_category \
				if cat_label != "S" \
				else "New record! You grew category S kale!"
	else:
		failure_label.text = \
				"You have been disqualified: your kale died" \
				if GradingManager.did_plant_die \
				else "You have been disqualified: your kale was too small"

	# Remember to display it
	grading_display.visible = true
