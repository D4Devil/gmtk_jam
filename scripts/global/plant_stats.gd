extends Node

## How large the plant grew
@export var size: float = 0.1

## The base value of growth. All modified will be applied to it.
@export var growth_rate_base: float = 0.5

## How fast the plant is growing at the moment
@export var growth_rate: float = 0.05

## Readonly value - just for previewing / debugging
@export var size_increase_per_second = 0.0

## Global multiplier of how fast the plant grows
@export var global_growth_multiplier = 0.1

## If gets to 0, plant dies
@export var health: float = 1.0

@export var max_water_capacity = 1.0
@export var current_water_volume = 0.5

## Current water level from 0..1 - calculated per frame
@export var water_level: float = 0.5

@export var max_size_expected: float = 100.0

## How much the growth value is muliplied by when changing the size.
## This modified is changing depending on the current size of the plant.
@onready var growth_mult_per_size: Curve = ResourceLoader.load("resources/balance/growth_multiplier_per_size.tres")

## Muliplier of the growth mult depending on the current water level
@onready var growth_mult_per_water: Curve = ResourceLoader.load("resources/balance/growth_multiplier_per_water.tres")

## How much health to add/remove per second depending on water level
@onready var health_change_per_water: Curve = ResourceLoader.load("resources/balance/health_change_per_water.tres")

## How much water capacity there is per size of the plant (size * sample)
@onready var water_cap_per_size: Curve = ResourceLoader.load("resources/balance/water_cap_per_size.tres")

## How much water (percentage per second) is lost (water decreases on it's own)
@onready var water_perc_loss_per_size: Curve = ResourceLoader.load("resources/balance/water_perc_loss_per_size.tres")

func _ready():
	print("In plant_stats _ready")
	reset_plant()
	GameStateMachine.state_changed.connect(on_game_state_changed)


func _process(delta):
	# Don't process plant stats when not in the GROWTH phase!
	if not GameStateMachine.state == GameStateMachine.GameState.GROWTH:
		return

	var size_sample_value = remap(size, 0, max_size_expected, 0, 1)

	# Apply water changes
	max_water_capacity = size * water_cap_per_size.sample(size_sample_value)
	current_water_volume -= max_water_capacity * water_perc_loss_per_size.sample(size_sample_value) * delta
	current_water_volume = clampf(current_water_volume, 0.0, max_water_capacity)
	water_level = current_water_volume / max_water_capacity

	# Apply health changes
	health += health_change_per_water.sample(water_level) * delta
	health = clampf(health, 0.0, 1.0)

	# Apply growth rate changes
	var water_growth_mult = growth_mult_per_water.sample(water_level)
	growth_rate = growth_rate_base * water_growth_mult
	growth_rate = clampf(growth_rate, 0.0, 1.0)

	# Apply growth to size
	size_increase_per_second = growth_rate * growth_mult_per_size.sample(size_sample_value) * global_growth_multiplier
	size += size_increase_per_second * delta


func reset_plant():
	var size_sample_value = remap(size, 0, max_size_expected, 0, 1)
	max_water_capacity = size * water_cap_per_size.sample(size_sample_value)
	current_water_volume = max_water_capacity / 2
	health = 1.0
	size = 0.1


func add_water_volume(volume: float):
	current_water_volume = clampf(current_water_volume + volume, 0, max_water_capacity)

func on_game_state_changed(
		_old_state: GameStateMachine.GameState,
		new_state: GameStateMachine.GameState):
	if new_state == GameStateMachine.GameState.GROWTH:
		reset_plant()