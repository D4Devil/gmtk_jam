extends Control

func change_water(value: float):
	PlantStats.add_water_volume(remap(value, 0, 1, 0, PlantStats.max_water_volume))
	
func change_fert(value: float):
	PlantStats.add_fert_volume(remap(value, 0, 1, 0, PlantStats.max_fert_volume))

func change_health(value: float):
	PlantStats.health += value