extends Node3D
## Spawns the player character with the arrow above
@onready var player_model: Node3D = $PlayerModel
@onready var arrow: Node3D = $PlayerModel/Arrow

# Called when the node enters the scene tree for the first time.
func _ready():
	# Adjust player pos / rot
	player_model.position += Vector3(randf_range(-0.1, 0.1), 0, randf_range(-0.1, 0.1))
	player_model.rotate_y(randf_range(-8, 8)/180)
	
	# Play arrow animation
	var anim_player = arrow.get_child(1) as AnimationPlayer
	anim_player.play("float")