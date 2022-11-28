extends Area2D

export (Array, Resource) var locked_messages := []
export (Array, Resource) var unlocked_messages := []
onready var _dialogue_box := preload("res://src/ui/MessageBox.tscn")
onready var _ui : CanvasLayer = owner.get_node("UI")

var unlocked := false


func _dialogue_finished(player : Area2D):
	player.set_process(true)


func action(player : Area2D):
	if not unlocked:
		var dialogue_box := _dialogue_box.instance()
		player.set_process(false)
		
		if Data.items.has(Globals.ItemsID.CROWBAR):
			dialogue_box.message_data = unlocked_messages
			unlocked = true
			Data.valve_wheel_enabled = true
			
		else:
			dialogue_box.message_data = locked_messages
			
		dialogue_box.connect("message_finished", self, "_dialogue_finished", [player])
		_ui.add_child(dialogue_box)


func _ready():
	unlocked = Data.valve_wheel_enabled
