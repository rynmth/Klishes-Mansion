extends Area2D

export (String, MULTILINE) var text : String
onready var _display := preload("res://src/ui/PaperDisplay.tscn")
onready var _ui : CanvasLayer = owner.get_node("UI")


func action(player : Area2D):
	if Data.get_meta("chased", false) : return
	player.set_process(false)
	
	var display := _display.instance()
	
	display.text = text
	_ui.add_child(display)
	yield(display, "finished")
	player.set_process(true)
