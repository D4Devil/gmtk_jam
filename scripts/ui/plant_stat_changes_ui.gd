extends Control

@export var health_label_scene: PackedScene
@export var health_positive_color: Color
@export var health_negative_color: Color

var labels: Array[Label] = []
var prev_health: float = -1.0

@onready var center_marker: Control = $CenterMarker

# Called when the node enters the scene tree for the first time.
func _ready():
	prev_health = PlantStats.health

func _on_health_update_timer_timeout():
	# Don't show any changes if there's no previous
	# health value
	if prev_health < 0:
		prev_health = PlantStats.health
		return

	var diff = (PlantStats.health - prev_health) * 100.0
	if (diff >= 1.0):
		# TODO: Spawn +X label
		var label = health_label_scene.instantiate() as Label
		#label.theme.set_color("font_color", health_positive_color)
		label.set("theme_override_colors/font_color", health_positive_color)
		label.text = "+%d" % diff
		label.position = center_marker.position
		add_child(label)
		print("Displayed +X")
		prev_health = PlantStats.health
	elif (diff <= -1.0):
		# TODO: Spawn -X label
		var label = health_label_scene.instantiate() as Label
		#label.theme.set_color("font_color", health_negative_color)
		label.set("theme_override_colors/font_color", health_negative_color)
		label.text = "%d" % diff
		label.position = center_marker.position
		add_child(label)
		print("Displayed -X")
		prev_health = PlantStats.health
