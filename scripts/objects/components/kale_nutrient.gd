class_name KaleNutrient
extends Node

@export var nutrient_type: Nutrients

enum Nutrients {Water, Minerals, Fertilizer}

func on_apply_nutrient(nutrient_volume: float):
    if nutrient_type == Nutrients.Water:
        PlantStats.add_water_volume(nutrient_volume)

    elif nutrient_type == Nutrients.Fertilizer:
        pass

    elif nutrient_type == Nutrients.Minerals:
        pass
