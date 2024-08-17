class_name FancyProgressBar
extends Control

@export var background_color: Color
@export var fill_color: Color
@export var minValue: float = 0.0
@export var maxValue: float = 1.0
@export var value: float = 0.5

@onready var background: ColorRect = $Background
@onready var fill: ColorRect = $Fill


func _ready():
	background.color = background_color
	fill.color = fill_color


func _process(_delta):
	var targetSize = remap(value, minValue, maxValue, 0, background.size.x)
	fill.size.x = targetSize

