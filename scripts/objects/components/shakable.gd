class_name Shakable
extends Node3D

@export_category("Tuning")
@export_subgroup("Nutrient")
@export var override_nutrient_value := 10
@export var override_nutrient_type := Nutrient.Nutrients.Water

@export_subgroup("Gameplay")
@export var shake_factor := 1.0
@export var use_threshold := 8
@export var particle : PackedScene
@export var spawn_point : Node3D
@export var spawn_point_target : Node3D
@export var particle_force : float

@export_subgroup("Animation")
@export var animatable : Node3D
@export var shake_axis := Vector3.UP
@export var speed := .25

@export_category("Dependencies")
@export var collision_object: PhysicsBody3D

var _shaking := 0.0
var _delta_animation := 0.0
var _anim_dir := 1
var _cached_anim_starting_pos : Vector3


func _ready() -> void:
	_cached_anim_starting_pos = animatable.position


func _process(delta: float) -> void:
	if _shaking <= 0:
		return
	
	_shaking = clampf(_shaking - delta, 0, 10)

	# Call for do some animation considering _shaking as anim speed
	_shake_animatable(delta)

	if _shaking > use_threshold:
		_use()


func _use() -> void:
	var nutrient = particle.instantiate() as NutrientParticle
	var dir := spawn_point.global_position.direction_to(spawn_point_target.global_position)
	owner.add_child(nutrient)
	nutrient.configure(dir, spawn_point, collision_object, override_nutrient_value, override_nutrient_type)


func _shake_animatable(delta: float):
	_delta_animation += delta * _anim_dir * _shaking

	if abs(_delta_animation) > shake_axis.length():
		_anim_dir *= -1
	
	animatable.global_position += shake_axis.normalized() * delta * _shaking * _anim_dir * speed


func on_stop_shake() -> void:
	_shaking = 0
	_delta_animation = 0
	_anim_dir = 1
	animatable.position = _cached_anim_starting_pos


func _on_used(use: bool) -> void:
	if use:
		_shaking += shake_factor
