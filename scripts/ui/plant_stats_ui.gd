extends Control

@onready var health_bar: FancyProgressBar = $HealthBar
@onready var growth_bar: FancyProgressBar = $GrowthBar
@onready var water_bar: FancyProgressBar = $WaterBar

func _ready():
	pass


func _process(_delta):
	health_bar.value = PlantStats.health
	growth_bar.value = PlantStats.growth_rate
	water_bar.value = PlantStats.water_level