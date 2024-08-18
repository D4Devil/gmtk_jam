class_name WateringCan
extends Pickable

var pouring_water := false
@export var watering_power: float = 1
@export_flags("Pipette:16") var drag_collision_layer := 16
@export var magic_speed_number := 10.0
@onready var droplet_scene := preload("res://scenes/objects/droplet.tscn")
@onready var drag_agent := $DragAgent
@onready var animator := $WateringCan/AnimationPlayer


func _ready() -> void:
	super._ready()
	drag_agent.plane_mask = drag_collision_layer
	drag_agent.enable = false
	animator.current_animation = "use"
	animator.animation_finished.connect(_on_animation_finished)
	var use : Animation = animator.get_animation("use")
	use.loop_mode = Animation.LoopMode.LOOP_NONE


func on_clickable_selected(_collision: Dictionary) -> void:
	super.on_clickable_selected(_collision)
	drag_agent.enable = true


func on_clickable_dropped() -> void:
	super.on_clickable_dropped()
	drag_agent.enable = false
	apply_impulse(drag_agent.velocity)
	pouring_water = false


func on_clickable_use(using: bool) -> void:
	pouring_water = using


func _process(_delta: float) -> void:
	if pouring_water:
		animator.play("use")
		print("using the watering can")
	else:
		print("Not using the watering can")
		animator.play_backwards("use")


func _on_animation_finished(_anim: String):
	await _spawn_water()
		

func _spawn_water():
	while pouring_water:
		print("Spawn water")
