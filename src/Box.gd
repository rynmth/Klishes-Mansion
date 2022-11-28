extends Area2D

export (bool) var is_static := false
onready var _grid : TileMap = get_parent()
onready var _tween : Tween = $Tween
onready var _stream_player : AudioStreamPlayer = $AudioStreamPlayer


func action(player : Area2D):
	var push_dir : Vector2 = player.global_position.direction_to(global_position)
	var dir : Vector2 = _grid.request_movement(self, push_dir)
	
	if dir and not is_static:
		player.set_process(false)
		yield(move_to_grid(dir), "completed")
		player.set_process(true)


func move_to_grid(target : Vector2) -> void:
	set_process(false)
	_stream_player.play()
	
	_tween.interpolate_property(
		self, "position", position, target, 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	_tween.start()
	yield(_tween, "tween_all_completed")
	yield(get_tree(), "idle_frame")
