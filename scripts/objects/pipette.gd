class_name Pipette
extends RigidBody3D

@export var watering_power: float = 1
@export_flags("Pipette:16") var drag_collision_layer := 16
@export var magic_speed_number := 10.0
@onready var droplet_scene := preload("res://scenes/objects/droplet.tscn")
@onready var draggable := $DragAgent

func _ready() -> void:
    GameStateMachine.state_changed.connect(on_game_state_changed)
    freeze_mode = FREEZE_MODE_KINEMATIC
    freeze = false
    draggable.enable = false
    draggable.plane_mask = drag_collision_layer


func on_game_state_changed(_previous: GameStateMachine.GameState, next: GameStateMachine.GameState) -> void:
    if next == GameStateMachine.GameState.GROWTH:
        freeze = false
    else:
        on_clickable_dropped()
        

func on_clickable_selected(_collision: Dictionary) -> void:
    freeze = true
    draggable.enable = true


func on_clickable_dropped() -> void:
    freeze = false
    draggable.enable = false
    apply_impulse(draggable.velocity)


func on_clickable_use(using: bool) -> void:
    if using:
        var droplet := droplet_scene.instantiate() as PhysicsBody3D
        get_parent().add_child(droplet)
        droplet.add_collision_exception_with(self)
        droplet.initial_speed = draggable.velocity * magic_speed_number
        droplet.global_position = global_position
