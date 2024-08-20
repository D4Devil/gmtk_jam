extends Control

@export var names_labels: Array[Label]

@onready var credits: VBoxContainer = $MarginContainer/Credits

func _ready():
	# Randomize the order of names
	for i in 10:
		var name_label = names_labels.pick_random()
		credits.move_child(name_label, -1)


func _on_quit_button_pressed():
	get_tree().quit()

func _on_start_button_pressed():
	GameStateMachine.on_new_game_started()
