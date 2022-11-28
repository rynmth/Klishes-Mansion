extends Area2D

export (String, FILE, "*.tscn") var target : String
export (int, "Up", "Left", "Down", "Right") var look_direction : int
export (int) var id : int
export (int) var unique_id := - 1
export (bool) var unlocked := false
export (Globals.ItemsID) var required := Globals.ItemsID.NONE
export (Array, Resource) var locked_messages := []
export (Array, Resource) var unlocked_messages := []

onready var _dialogue_box := preload("res://src/ui/MessageBox.tscn")
onready var _ui : CanvasLayer = owner.get_node("UI")
onready var _door_open : AudioStreamPlayer = $Open
onready var _door_locked : AudioStreamPlayer = $Locked

var look_dirs := [
	Vector2.UP,
	Vector2.LEFT,
	Vector2.DOWN,
	Vector2.RIGHT
]


func warp(player : Area2D) -> void:
	var transition : ColorRect = owner.get_node("UI/Transition")
	
	player.warping = true
	_door_open.play()
	transition.fade_in()
	yield(transition, "finished")
	yield(_door_open, "finished")
	
	Data.set_meta("look_dir", look_dirs[look_direction])
	Data.set_meta("teleporter_id", id)
	
	get_tree().change_scene(target)


func _dialogue_finished(player : Node2D):
	if unlocked:
		warp(player)
		
	player.set_process(true)


func action(player : Area2D):
	player.set_process(false)
	
	if not unlocked:
		if Data.get_meta("chased", false) : return
		var dialogue_box : Control = _dialogue_box.instance()
		
		dialogue_box.connect("message_finished", self, "_dialogue_finished", [player])
		
		if Data.items.has(required):
			dialogue_box.message_data = unlocked_messages
			unlocked = true
			Data.unlocked_doors.append(unique_id)
		
		else:
			dialogue_box.message_data = locked_messages
			
			if required != Globals.ItemsID.LAMP:
				_door_locked.play()
				yield(_door_locked, "finished")
			
		_ui.add_child(dialogue_box)
		return
		
	warp(player)


func _ready():
	if Data.unlocked_doors.has(unique_id):
		unlocked = true
