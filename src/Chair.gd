extends Node2D

onready var _grid : TileMap = get_parent().get_node("Solid")


func _ready():
	global_position = _grid.map_to_world(_grid.world_to_map(global_position)) + _grid.cell_size / 2
	add_to_group("entities")
