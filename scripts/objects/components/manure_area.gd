extends Area3D


func on_body_entered(body: Node3D) -> void:
	if body is Shovel:
		body = body as Shovel
		body.on_body_entered(self)


func on_body_exited(body: Node3D) -> void:
	if body is Shovel:
		body.on_body_exited(self)
