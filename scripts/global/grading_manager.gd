extends Node

@export var categories: Array[GradingCategory]
@export var participants_per_category: int

signal size_graded()

var is_disqualified: bool = false
var did_plant_die: bool = false
var assigned_category: GradingCategory
var place_in_category: int


func grade_size():
  # Calculate the category
	if PlantStats.health <= 0.0:
		print("Disqualified due to plant dead")
		is_disqualified = true
		did_plant_die = true
		size_graded.emit()
		return

	if not check_if_qualifies():
		print("Disqualified due to too small plant")
		is_disqualified = true
		did_plant_die = false
		size_graded.emit()
		return

	is_disqualified = false
	did_plant_die = false

	var result = calc_category()
	assigned_category = result[0]
	var max_size = result[1]
	print("Assigned category: %s" % assigned_category.label)
	print("Min size: %d" % assigned_category.min_size)
	print("Max size: %d" % max_size)

	# Calculate the place withing the category
	place_in_category = calc_place(assigned_category.min_size, max_size)
	print("Player's place: %d" % place_in_category)
	
	size_graded.emit()



func check_if_qualifies():
	return PlantStats.size >= categories[0].min_size


## Finds which category plant belong to and returns the max size for the category
func calc_category():
	var plant_size = PlantStats.size
	var count = categories.size() - 1
	var max_size = 99999999999999.0 # Max size for the category
	for i in range(count + 1):
		var category = categories[count - i]
		# If plant size is within the category
		if plant_size >= category.min_size:
			return [category, max_size]
		max_size = category.min_size

	push_error("Player should have been already disqualified. This should never be reached")


func calc_place(min_size: float, max_size: float):
	var current_size = PlantStats.size
	var placeFloat = remap(current_size, min_size, max_size, 1, participants_per_category + 1)
	var place = floori(placeFloat)
	return participants_per_category - place + 1
