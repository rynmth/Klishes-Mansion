extends Control

onready var _label : Label = $CenterContainer/PanelContainer/MarginContainer/Label

signal finished

var text : String


func _ready():
	var tween := create_tween()
	
	modulate = Color(0.0, 0.0, 0.0, 0.0)
	tween.tween_property(self, "modulate", Color.white, 0.3)
	_label.text = text


func _process(_delta : float):
	if Input.is_action_just_pressed("ui_accept"):
		var tween := create_tween()
		
		tween.tween_property(self, "modulate", Color(0.0, 0.0, 0.0, 0.0), 0.3)
		tween.tween_callback(self, "emit_signal", ["finished"])
		tween.tween_callback(self, "queue_free")
