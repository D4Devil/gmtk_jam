class_name Utils

## Gets the mouse position and projects it to the game world. returns collision data
static func screen_to_3d_object(node: Node3D, collision_mask: int = 4294967295) -> Dictionary:
	var mouse_position = node.get_viewport().get_mouse_position()
	var cam = node.get_viewport().get_camera_3d()
	var origin = cam.project_ray_origin(mouse_position)
	var location_on_plane = cam.project_position(mouse_position, 100)
	var dir = location_on_plane - origin
	var query = PhysicsRayQueryParameters3D.create(origin, dir * 10, collision_mask)
	
	## Query the 3d direct space state, retrives a dictionary with collision
	return node.get_world_3d().direct_space_state.intersect_ray(query)

static func rand_pos_in_sphere():
	var rand_vector = Vector3(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
	return rand_vector * (1.0 / rand_vector.length())