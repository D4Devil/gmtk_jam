class_name Utils

## Gets the mouse position and projects it to the game world. returns collision data
static func screen_to_3d_object(node: Node3D, collision_mask: int = 4294967295) -> Dictionary:
	var mouse_position = node.get_viewport().get_mouse_position()
	var cam = node.get_viewport().get_camera_3d()
	var origin = cam.project_ray_origin(mouse_position)
	var dir = cam.project_ray_normal(mouse_position) * 10000
	var query = PhysicsRayQueryParameters3D.create(origin, dir, collision_mask)
	
	## Query the 3d direct space state, retrives a dictionary with collision
	return node.get_world_3d().direct_space_state.intersect_ray(query)
