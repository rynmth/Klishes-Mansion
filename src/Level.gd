extends YSort

onready var _player := preload("res://src/player/Player.tscn")
onready var _enemy := preload("res://src/Enemy.tscn")
onready var _transition : ColorRect = get_node("UI/Transition")
onready var _dialogue_box := preload("res://src/ui/MessageBox.tscn")
onready var _open_door : AudioStreamPlayer = $DoorOpen
onready var _close_door : AudioStreamPlayer = $DoorClose
onready var _glass_breaking : AudioStreamPlayer = $GlassBreaking
onready var _ui : CanvasLayer = get_node("UI")
onready var _timer := $ChaseTimer
export (float) var chase_delay := 5.0
export (bool) var flash_light := false
export (Globals.LocationsID) var level_id : int
export (bool) var save_from_start := false

signal shadow_continue

var start_position : Vector2


func spawn_player(pos : Vector2, look_dir : Vector2) -> void:
	var player := _player.instance()
	
	player.global_position = pos
	add_child(player)
	player.set_direction(look_dir, true)
	player._light.enabled = flash_light
	player.set_process(false)
	Data.set_meta("from_pos", save_from_start)
	Data.set_meta("scene_pos", pos)
	Data.set_meta("scene_look", look_dir)


func _hidden_timeout(timer : Timer):
	emit_signal("shadow_continue")
	timer.queue_free()


func spawn_enemy(pos : Vector2 = Data.last_teleporter) -> void:
	var enemy := _enemy.instance()
	
	if Data.get_meta("no_spawn", false) : return
	
	if Data.get_meta("hidden", false):
		var timer := Timer.new()
		
		_open_door.play()
		add_child(timer)
		timer.start(3.0)
		timer.connect("timeout", self, "_hidden_timeout", [timer])
		yield(self, "shadow_continue")
		
		if Data.get_meta("hidden", false):
			Data.set_meta("chased", false)
			_close_door.play()
			Chase.stop()
			return
			
		enemy.global_position = get_node("Player").global_position
			
	else:
		enemy.global_position = pos
		Data.set_meta("chased", true)
	
	if not Chase.playing : Chase.play()
	
	add_child(enemy)
	enemy.node_target = get_node("Player")


func teleport_to(direction : Vector2, id : int) -> void:
	for t_rec in get_tree().get_nodes_in_group("teleporter_receiver"):
		if t_rec is Position2D:
			if t_rec.id == id:
				start_position = t_rec.global_position
				Data.last_teleporter = start_position
				spawn_player(start_position, direction)


func _ready():
	if Data.get_meta("chased", false):
		Chase.play()
	
	Data.current_location = level_id
	
	if Data.items.has(Globals.ItemsID.MANSION_KEY):
		chase_delay = 5.0 if level_id == Globals.LocationsID.ENTRANCE else 0.5
	
	if save_from_start:
		start_position = Data.last_teleporter
	
	if Data.get_meta("load_game", false):
		Data.set_meta("load_game", false)
		spawn_player(Data.last_position, Data.last_direction)
	
	else:
		teleport_to(Data.get_meta("look_dir", Vector2.UP), Data.get_meta("teleporter_id", 0))
	
	_transition.fade_out()
	yield(_transition, "finished")
	get_node("Player").set_process(true)
	
	if Data.first_time:
		var player := get_node("Player")
		var dialogue_box := _dialogue_box.instance()
		
		player.warping = true
		dialogue_box.message_data = [load("res://src/dialogues/first_time1.tres"), load("res://src/dialogues/first_time2.tres")]
		_ui.add_child(dialogue_box)
		yield(dialogue_box, "message_finished")
		
		_glass_breaking.play()
		yield(_glass_breaking, "finished")
		get_node("Player").set_direction(Vector2.RIGHT, true)
		
		dialogue_box = _dialogue_box.instance()
		dialogue_box.message_data = [load("res://src/dialogues/first_time3.tres"), load("res://src/dialogues/first_time4.tres")]
		_ui.add_child(dialogue_box)
		yield(dialogue_box, "message_finished")
		Data.first_time = false
		player.warping = false
	
	if Data.get_meta("chased", false):
		_timer.start(chase_delay)
