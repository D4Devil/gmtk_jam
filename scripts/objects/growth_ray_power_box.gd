extends Node3D

@export var ray_tower: GrowthRayTower

func on_click():
	ray_tower.on_power_on()
