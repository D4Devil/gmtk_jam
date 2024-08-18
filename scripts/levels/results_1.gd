extends Node3D

@export var npc_spawner: PackedScene
@export var player_spawner: PackedScene

@onready var participant_slots: Node3D = $ParticipantSlots
@onready var crowd_slots: Node3D = $CrowdSlots


func _ready():
	GradingManager.grade_size() # Calculate all the grades

	# Spawn participants
	var slot_nodes = participant_slots.get_children()
	var place := 1
	var player_place = -1 if GradingManager.is_disqualified else GradingManager.place_in_category
	for slot_node in slot_nodes:
		spawn_character(slot_node, place == player_place)
		place += 1

	# Spawn crowd
	slot_nodes = crowd_slots.get_children()
	var player_spot =  randi_range(0, slot_nodes.size() - 1) if GradingManager.is_disqualified else -1
	var current_spot = 0
	for slot_node in slot_nodes:
		spawn_character(slot_node, current_spot == player_spot)
		current_spot += 1

	# TODO: Spawn player's kale in appropriate location


func spawn_character(slot: Node3D, is_player: bool):
	var character_scene = player_spawner if is_player else npc_spawner
	var character = character_scene.instantiate() as Node3D
	slot.add_child(character)
