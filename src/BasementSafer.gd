extends Area2D

export (Array, Resource) var locked_messages := []
export (Array, Resource) var unlocked_messages := []
onready var _dialogue_box := preload("res://src/ui/MessageBox.tscn")
onready var _ui : CanvasLayer = owner.get_node("UI")
onready var _stream_player : AudioStreamPlayer = $AudioStreamPlayer

var unlocked := false


func action(player : Area2D):
	player.set_process(false)
	
	if not unlocked:
		var dialogue_box := _dialogue_box.instance()
		
		if Data.basement_safer_unlocked:
			dialogue_box.message_data = unlocked_messages
			unlocked = true
			Data.items.append(Globals.ItemsID.CLEANING_ROOM_KEY)
			_stream_player.play()
			
		else:
			dialogue_box.message_data = locked_messages
			
		_ui.add_child(dialogue_box)
		yield(dialogue_box, "message_finished")
	
	player.set_process(true)


func _ready():
	if Data.items.has(Globals.ItemsID.CLEANING_ROOM_KEY):
		unlocked = true
