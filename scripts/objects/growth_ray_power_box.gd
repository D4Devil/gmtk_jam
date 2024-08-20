extends Node3D

@export var ray_tower: GrowthRayTower

@onready var click_sound: AudioStreamPlayer3D = $ClickSound

func on_click():
	click_sound.play()
	ray_tower.on_power_on()
