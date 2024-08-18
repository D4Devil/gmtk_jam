class_name Pipette
extends RigidBody3D

@export var watering_power: float = 1
@export var drag_collision_layer := 16

@onready var draggable := $DragAgent

func _ready() -> void:
    GameStateMachine.state_changed.connect(on_game_state_changed)
    freeze_mode = FREEZE_MODE_KINEMATIC
    freeze = true
    draggable.enable = false
    draggable.plane_mask = drag_collision_layer


func on_game_state_changed(_previous: GameStateMachine.GameState, next: GameStateMachine.GameState) -> void:
    if next == GameStateMachine.GameState.GROWTH:
        freeze = false
        

func on_clickable_selected(_collision: Dictionary) -> void:
    freeze = true
    draggable.enable = true
    


func on_clickable_dropped() -> void:
    freeze = false
    draggable.enable = false


func on_clickable_use(using: bool) -> void:
    if using:
        PlantStats.add_water_volume(watering_power)
