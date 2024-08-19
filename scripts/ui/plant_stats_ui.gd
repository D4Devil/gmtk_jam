extends Control

@onready var water_bar: TextureProgressBar = $MarginContainer/HBoxContainer/VBoxContainer/Water/WaterBar
@onready var grow_factor_bar: TextureProgressBar = $MarginContainer/HBoxContainer/GrowFactor/GrowFactorBar
@onready var health_bar: TextureProgressBar = $MarginContainer/HBoxContainer/Health/HealthBar
@onready var time_bar: TextureProgressBar = $MarginContainer/HBoxContainer/Time/TimeBar
@onready var countdown_label: Label = $MarginContainer/HBoxContainer/Time/MarginContainer/CountdownLabel

func _ready():
	time_bar.min_value = 0.0
	time_bar.max_value = GrowthTimer.total_time
	time_bar.value = GrowthTimer.time_left


func _process(_delta):
	health_bar.value = PlantStats.health
	grow_factor_bar.value = PlantStats.growth_rate
	water_bar.value = PlantStats.water_level
	time_bar.value = GrowthTimer.time_left
	countdown_label.text = "%ds" % GrowthTimer.time_left
