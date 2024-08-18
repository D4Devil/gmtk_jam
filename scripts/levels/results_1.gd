extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	GradingManager.grade_size() # Calculate all the grades
	# TODO: Make changes in the scene depending on the category and place