extends Control

@export var health_label_scene: PackedScene
@export var health_positive_color: Color
@export var health_negative_color: Color

var prev_health: float = -1.0

@onready var center_marker: Control = $CenterMarker
@onready var health_update_timer: Timer = $HealthUpdateTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()

func stop():
	prev_health = PlantStats.health
	health_update_timer.stop()

func reset():
	prev_health = PlantStats.health
	health_update_timer.start()

func _on_health_update_timer_timeout():
	# Don't show any changes if there's no previous
	# health value
	if prev_health < 0:
		prev_health = PlantStats.health
		return

	var diff = (PlantStats.health - prev_health) * 100.0
	if (diff >= 1.0):
		var label = health_label_scene.instantiate() as Label
		label.set("theme_override_colors/font_color", health_positive_color)
		label.text = "+%d" % diff
		label.position = center_marker.position
		add_child(label)
		prev_health = PlantStats.health
	elif (diff <= -1.0):
		var label = health_label_scene.instantiate() as Label
		label.set("theme_override_colors/font_color", health_negative_color)
		label.text = "%d" % diff
		label.position = center_marker.position
		add_child(label)
		prev_health = PlantStats.health
