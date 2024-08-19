extends Node

## How large the plant grew
@export var size: float = 0.1

## [SETTING] The base value of growth. All modified will be applied to it.
@export var growth_rate_base: float = 0.25

## How fast the plant is growing at the moment
@export var growth_rate: float = growth_rate_base

## How much size increases per second - just for previewing / debugging
@export var size_increase_per_second = 0.0

## [SETTING] Global multiplier of how fast the plant grows
@export var global_growth_multiplier = 0.2

## If gets to 0, plant dies
@export var health: float = 1.0

@export var max_water_volume = 1.0
@export var current_water_volume = 0.5

## Current water level from 0..1 - calculated per frame
@export var water_level: float = 0.5

## [SETTING] The maximum size of the plant expected - Deines 1.0 on X axis in config curves
@export var max_size_expected: float = 100.0


@export var max_fert_volume: float = 1.0
@export var current_fert_volume: float = 0.0
@export var fert_level: float = 0.0

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

@onready var growth_mult_per_fert: Curve = ResourceLoader.load("resources/balance/growth_multiplier_per_fert.tres")
@onready var health_change_per_fert: Curve = ResourceLoader.load("resources/balance/health_change_per_fert.tres")
@onready var fert_cap_per_size: Curve = ResourceLoader.load("resources/balance/fert_cap_per_size.tres")
@onready var water_loss_mult_per_fert: Curve = ResourceLoader.load("resources/balance/water_loss_mult_per_fert.tres")
@onready var fert_perc_loss_per_size: Curve = ResourceLoader.load("resources/balance/fert_perc_loss_per_size.tres")



func _ready():
	print("In plant_stats _ready")
	reset_plant()
	GameStateMachine.state_changed.connect(on_game_state_changed)


func _process(delta):
	# Don't process plant stats when not in the GROWTH phase!
	if not GameStateMachine.state == GameStateMachine.GameState.GROWTH:
		return

	var size_sample_value = remap(size, 0, max_size_expected, 0, 1)

	# Apply fertilizer changes
	max_fert_volume = size * water_cap_per_size.sample(size_sample_value)
	current_fert_volume -= max_fert_volume * fert_perc_loss_per_size.sample(size_sample_value) * delta
	current_fert_volume = clampf(current_fert_volume, 0.0, max_fert_volume)
	fert_level = current_fert_volume / max_fert_volume

	# Apply water changes
	max_water_volume = size * fert_cap_per_size.sample(size_sample_value)
	var water_loss_perc = water_perc_loss_per_size.sample(size_sample_value) * water_loss_mult_per_fert.sample(size_sample_value)
	current_water_volume -= max_water_volume * water_loss_perc * delta
	current_water_volume = clampf(current_water_volume, 0.0, max_water_volume)
	water_level = current_water_volume / max_water_volume

	# Apply health changes
	health += health_change_per_water.sample(water_level) * delta
	health += health_change_per_fert.sample(water_level) * delta
	health = clampf(health, 0.0, 1.0)

	# Apply growth rate changes
	var water_growth_mult = growth_mult_per_water.sample(water_level)
	var fert_growth_mult = growth_mult_per_fert.sample(fert_level)
	growth_rate = growth_rate_base * water_growth_mult * fert_growth_mult
	growth_rate = clampf(growth_rate, 0.0, 1.0)

	# Apply growth to size
	size_increase_per_second = growth_rate * growth_mult_per_size.sample(size_sample_value) * global_growth_multiplier
	size += size_increase_per_second * delta

	if health <= 0.0:
		on_plant_killed()


func reset_plant():
	var size_sample_value = remap(size, 0, max_size_expected, 0, 1)
	max_water_volume = size * water_cap_per_size.sample(size_sample_value)
	current_water_volume = max_water_volume / 2
	max_fert_volume = size * fert_cap_per_size.sample(size_sample_value)
	current_fert_volume = 0.0
	health = 1.0
	size = 0.1


func on_plant_killed():
	GameStateMachine.on_growth_finished()


func add_water_volume(volume: float):
	current_water_volume = clampf(current_water_volume + volume, 0, max_water_volume)

func add_fert_volume(volume: float):
	current_fert_volume = clampf(current_fert_volume + volume, 0, max_fert_volume)

func on_game_state_changed(
		_old_state: GameStateMachine.GameState,
		new_state: GameStateMachine.GameState):
	if new_state == GameStateMachine.GameState.GROWTH:
		reset_plant()
