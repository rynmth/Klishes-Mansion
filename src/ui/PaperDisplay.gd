extends Control

onready var _label : Label = $CenterContainer/PanelContainer/MarginContainer/Label

signal finished

var text : String


func _ready():
	var tween := create_tween()
	
	modulate = Color(0.0, 0.0, 0.0, 0.0)
	tween.tween_property(self, "modulate", Color.white, 0.3)
	_label.text = text


func _input(event : InputEvent):
	if event is InputEventScreenTouch and event.pressed:
		destroy()


func _unhandled_input(event : InputEvent):
	if event is InputEventKey and event.pressed:
		destroy()


func destroy():
	var tween := create_tween()
	
	tween.tween_property(self, "modulate", Color(0.0, 0.0, 0.0, 0.0), 0.3)
	tween.tween_callback(self, "emit_signal", ["finished"])
	tween.tween_callback(self, "queue_free")
