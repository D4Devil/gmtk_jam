extends Node3D

@export var npc_spawner: PackedScene
@export var player_spawner: PackedScene
@export var kale_spawner: PackedScene
@export var kale_spots: Array[KaleResultSpawnPoint]

@onready var participant_slots: Node3D = $ParticipantSlots
@onready var crowd_slots: Node3D = $CrowdSlots
@onready var kale_slots: Node3D = $KaleSlots

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

	# Spawn player's kale in appropriate location
	if not GradingManager.is_disqualified:
		spawn_kale()

func spawn_character(slot: Node3D, is_player: bool):
	var character_scene = player_spawner if is_player else npc_spawner
	var character = character_scene.instantiate() as Node3D
	slot.add_child(character)


func spawn_kale():
	var kale_size = PlantStats.size
	for kale_spot_def in kale_spots:
		if kale_size < kale_spot_def.min_size or kale_size >= kale_spot_def.max_size:
			continue
		# TODO: Spawn kale here
		var kale_slot = kale_slots.find_child(kale_spot_def.node_name)
		if kale_slot == null:
			push_error("Can't find marker for the kale slot %s", kale_spot_def.node_name)
			return
		var kale_node = kale_spawner.instantiate()
		kale_slot.add_child(kale_node)
		return

	print("Couldn't find a spot for kale to spawn")
