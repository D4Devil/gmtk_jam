extends Control

@onready var timer_bar: FancyProgressBar = $TimerBar
@onready var countdown_label: Label = $TimerBar/CountdownLabel

func _ready():
	timer_bar.minValue = 0.0
	timer_bar.maxValue = GrowthTimer.total_time
	timer_bar.value = GrowthTimer.time_left


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	timer_bar.value = GrowthTimer.time_left
	countdown_label.text = "%ds" % GrowthTimer.time_left
