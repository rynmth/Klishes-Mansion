extends Area2D

onready var _transition := preload("res://src/Transition.tscn")
onready var _dialogue_box := preload("res://src/ui/MessageBox.tscn")
onready var _ui : CanvasLayer = owner.get_node("UI")
var target := "res://src/rooms/Bathroom.tscn"
var id := 0
var unique_id := 12
var unlocked := false
var locked_messages := [
	load("res://src/dialogues/flooded_room.tres")
]
var unlocked_messages := [
	load("res://src/dialogues/bathroom_unlocked.tres")
]

func warp(player : Area2D) -> void:
	var transition := owner.get_node("UI/Transition")
	
	player.warping = true
	transition.fade_in()
	yield(transition, "finished")
	
	Data.set_meta("look_dir", Vector2.RIGHT)
	Data.set_meta("teleporter_id", 0)
	
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
		
		if Data.valve_wheel_enabled:
			dialogue_box.message_data = unlocked_messages
			unlocked = true
			Data.unlocked_doors.append(unique_id)
		
		else:
			dialogue_box.message_data = locked_messages
			
		_ui.add_child(dialogue_box)
		return
		
	warp(player)


func _ready():
	if Data.unlocked_doors.has(unique_id):
		unlocked = true
