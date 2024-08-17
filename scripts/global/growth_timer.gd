extends Node

## Total time available for growth (in seconds)
@export var total_time: float = 5.0 * 60

var time_left: float = total_time

signal timeout()

func _ready():
	time_left = total_time

func _process(delta):
	time_left -= delta
	if (time_left <= 0.0):
		time_left = 0
		timeout.emit()

func reset():
	time_left = total_time