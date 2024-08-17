extends Label

var velocity: Vector2

func _ready():
	velocity = Vector2(randf_range(-300, 300), randf_range(-250, -500))

	# Delete itself in 1 second
	get_tree().create_timer(2.0).timeout.connect(queue_free)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity += Vector2(0, 1500) * delta
	velocity *= 1.0 - (0.05 * delta)
	position += velocity * delta
