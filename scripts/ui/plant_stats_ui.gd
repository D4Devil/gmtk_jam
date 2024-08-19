extends Control

@onready var water_bar: TextureProgressBar = $MarginContainer/HBoxContainer/VBoxContainer/Water/WaterBar
@onready var fertilizer_bar: TextureProgressBar = $MarginContainer/HBoxContainer/VBoxContainer/Fertilizer/FertilizerBar
@onready var grow_factor_bar: TextureProgressBar = $MarginContainer/HBoxContainer/GrowFactor/GrowFactorBar
@onready var health_bar: TextureProgressBar = $MarginContainer/HBoxContainer/Health/HealthBar
@onready var time_bar: TextureProgressBar = $MarginContainer/HBoxContainer/Time/TimeBar
@onready var countdown_label: Label = $MarginContainer/HBoxContainer/Time/MarginContainer/CountdownLabel

@onready var scale_label: Label = $StatsTopLeft/ScaleLabel

func _ready():
	time_bar.min_value = 0.0
	time_bar.max_value = GrowthTimer.total_time
	time_bar.value = GrowthTimer.time_left


func _process(_delta):
	health_bar.value = PlantStats.health
	grow_factor_bar.value = PlantStats.growth_rate
	water_bar.value = PlantStats.water_level
	fertilizer_bar.value = PlantStats.fert_level
	time_bar.value = GrowthTimer.time_left
	countdown_label.text = "%ds" % GrowthTimer.time_left
	scale_label.text = "Kale scale: %.1f" % PlantStats.size
