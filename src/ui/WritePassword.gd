extends Control

onready var _line : LineEdit = $LineEdit

signal password_entered(value)

var regex : RegEx


func set_max_length(length : int) -> void:
	_line.max_length = length


func _ready():
	regex = RegEx.new()
	regex.compile("[^0-9]")
	
	var tween := create_tween()
	
	modulate = Color(0.0, 0.0, 0.0, 0.0)
	tween.tween_property(self, "modulate", Color.white, 0.2)
	tween.tween_callback(_line, "grab_focus")


func _on_LineEdit_text_changed(new_text : String):
	var result := regex.search(new_text)
	
	if not result : return
	
	var caret := _line.caret_position + 1
	
	_line.text = new_text.replace(result.get_string(), "")
	_line.caret_position = caret


func _on_LineEdit_text_entered(_new_text : String):
	emit_signal("password_entered", _line.text as int)
	
	var tween := create_tween()
	
	tween.tween_property(self, "modulate", Color(0.0, 0.0, 0.0, 0.0), 0.2)
	tween.tween_callback(self, "queue_free")
