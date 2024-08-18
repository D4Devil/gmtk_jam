class_name Nutrient
extends Node

@export var nutrient_type: Nutrients
var nutrient_volume: float

enum Nutrients {Water, Minerals, Fertilizer}

func apply():
    if nutrient_type == Nutrients.Water:
        PlantStats.add_water_volume(nutrient_volume)

    elif nutrient_type == Nutrients.Fertilizer:
        pass

    elif nutrient_type == Nutrients.Minerals:
        pass
