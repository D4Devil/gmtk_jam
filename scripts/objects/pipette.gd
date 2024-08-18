class_name Pipette
extends RigidBody3D

@export var watering_power: float = 1
@export_flags("Pipette:16") var drag_collision_layer := 16
@onready var droplet := preload("res://scenes/objects/droplet.tscn")

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
        var d := droplet.instantiate() as Node3D
        (d as PhysicsBody3D).add_collision_exception_with(self)
        d.global_position = global_position
        get_parent().add_child(d)
