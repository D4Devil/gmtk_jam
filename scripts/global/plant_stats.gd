extends Node

## How large the plant grew
@export var size: float = 0.1

## How fast the plant is growing at the moment
@export var growth_rate: float = 0.05

## How slowly we're loosing the growth rate
@export var growth_slowdown_rate: float = 0.002

## If gets to 0, plant dies
@export var health: float = 1.0

## Current water level - needs to be balanced
@export var water_level: float = 0.0

func _process(delta):
	size += growth_rate * delta
	growth_rate = move_toward(growth_rate, 0.0, growth_slowdown_rate * delta)