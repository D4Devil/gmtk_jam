class_name Pipette
extends CharacterBody3D


@export var watering_power: float = 1
@onready var origin := transform.origin


func on_clickable_selected(collision: Dictionary) -> void:
    print('Pipette selected')


func on_clickable_dropped() -> void:
    print('Pipette Dropped')


func on_clickable_use(using: bool) -> void:
    if using:
        print('Drowning the plant >:)')
        PlantStats.add_water_volume(watering_power)
