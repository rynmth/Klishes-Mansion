extends Area2D

onready var _grid : TileMap = get_parent().get_node("Ground")
onready var _col_grid : TileMap = get_parent().get_node("Solid")
onready var _tween : Tween = $Tween
onready var _anim_player : AnimationPlayer = $AnimationPlayer
onready var _transition : ColorRect = get_parent().get_node("UI/Transition")

var astar : AStar2D
var node_target : Area2D
var node_target_last_pos : Vector2
var path : PoolVector2Array
var cells : PoolVector2Array
var valid_cells : PoolVector2Array
var dirs := [
	Vector2.UP,
	Vector2.LEFT,
	Vector2.DOWN,
	Vector2.RIGHT
]


func is_blocked(pos : Vector2) -> bool:
	for node in get_tree().get_nodes_in_group("entities"):
		if pos == _grid.world_to_map(node.global_position):
			return true
		
	return false


func _process(_delta : float):
	if not node_target or node_target.warping: return
	
	if _grid.world_to_map(node_target.global_position) != node_target_last_pos:
		node_target_last_pos = _grid.world_to_map(node_target.global_position)
		astar.clear()
		valid_cells.resize(0)
		
		for cell in cells:
			if is_blocked(cell) or _col_grid.get_cellv(cell) != -1 : continue
			astar.add_point(cantor_pairing(cell), cell)
			valid_cells.append(cell)
		
		for cell in valid_cells:
			for dir in dirs:
				var next_cell : Vector2 = cell + dir
				
				if valid_cells.has(next_cell):
					astar.connect_points(cantor_pairing(cell), cantor_pairing(next_cell))
					
		path = astar.get_point_path(cantor_pairing(_grid.world_to_map(global_position)), cantor_pairing(_grid.world_to_map(node_target.global_position)))
		path.remove(0)
	
	if path.size():
		var dir : Vector2 = path[0]
		
		set_direction(_grid.world_to_map(global_position).direction_to(dir))
		move_to_grid(_grid.map_to_world(dir) + _grid.cell_size / 2)
		path.remove(0)


func cantor_pairing(vec : Vector2) -> int:
	return int((vec.x + vec.y) * (vec.x + vec.y + 1) / 2 + vec.y)


func set_direction(direction : Vector2) -> void:
	match direction:
		Vector2.UP : _anim_player.play("walk_up")
		Vector2.LEFT : _anim_player.play("walk_left")
		Vector2.DOWN : _anim_player.play("walk_down")
		Vector2.RIGHT : _anim_player.play("walk_right")


func move_to_grid(target : Vector2) -> void:
	set_process(false)
	
	_tween.interpolate_property(
		self, "position", position, target,
		_anim_player.current_animation_length / _anim_player.playback_speed,
		Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	_tween.start()
	
	yield(_anim_player, "animation_finished")
	set_process(true)


func _ready():
	global_position = _grid.map_to_world(_grid.world_to_map(global_position)) + _grid.cell_size / 2
	astar = AStar2D.new()
	
	for cell in _grid.get_used_cells():
		cells.append(cell)


func _on_Enemy_area_entered(player : Area2D):
	if not player.name == "Player" : return
	
	Data.set_meta("hidden", false)
	Chase.stop()
	player.set_process(false)
	player._tween.stop_all()
	get_tree().change_scene("res://src/ui/GameOver.tscn")
