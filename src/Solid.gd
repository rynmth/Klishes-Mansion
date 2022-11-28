extends TileMap


func _ready():
	for node in get_children():
		node.position = map_to_world(world_to_map(node.position)) + cell_size / 2
		
		if node.has_method("_set_is_open"):
			if node.is_open and node.to_string() == "DoorBarrier":
				continue
		
		node.add_to_group("entities")


func request_movement(node : Node2D, direction : Vector2) -> Vector2:
	var start = world_to_map(node.position)
	var target = start + direction
	var target_type := get_cellv(target)
	
	if target_type == -1 or target_type == 19:
		for node in get_tree().get_nodes_in_group("entities"):
			var pos = world_to_map(node.position)
			
			if target == pos : return Vector2.ZERO
			
		return map_to_world(target) + cell_size / 2
		
	return Vector2.ZERO

