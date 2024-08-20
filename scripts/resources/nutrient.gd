class_name Nutrient
extends Resource

@export var nutrient_type: Nutrients
@export var volume: float

enum Nutrients {Water, Minerals, Fertilizer}

func _init(nt := Nutrients.Water, vol := 0.2) -> void:
    nutrient_type = nt
    volume = vol


func on_applyed():
    if nutrient_type == Nutrients.Water:
        PlantStats.add_water_volume(volume)

    elif nutrient_type == Nutrients.Fertilizer:
        PlantStats.add_fert_volume(volume)

    elif nutrient_type == Nutrients.Minerals:
        pass
