extends Control

onready var _name : Label = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/PanelContainer/MarginContainer/Name
onready var _text : RichTextLabel= $MarginContainer/VBoxContainer/PanelContainer/MarginContainer/RichTextLabel
onready var _list : HBoxContainer = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer
onready var _tween : Tween = $Tween
onready var _next : AudioStreamPlayer = $AudioStreamPlayer
onready var _choice_box = preload("res://src/ui/ChoiceBox.tscn")

signal choice_selected(id)
signal message_finished

var message_data := []
var current_message := 0


func _gui_input(event : InputEvent):
	if event is InputEventScreenTouch and event.pressed:
		_next.play()
		advance_text()


func _process(_delta : float):
	if Input.is_action_just_pressed("ui_accept"):
		_next.play()
		advance_text()


func advance_text() -> void:
	if _tween.is_active() and current_message < message_data.size():
		_tween.stop_all()
		_text.percent_visible = 1.0
		
		if message_data[current_message].choices:
			create_choice_box(message_data[current_message].choices)
		
		else : current_message += 1
		
		return
		
	elif current_message >= message_data.size():
		var tw := create_tween().set_ease(Tween.EASE_OUT)
		
		set_process_unhandled_input(false)
		set_process_unhandled_input(false)
		tw.tween_property(self, "modulate", Color(0, 0, 0, 0), 0.2)
		tw.tween_callback(self, "emit_signal", ["message_finished"])
		tw.tween_callback(self, "queue_free")
		return
	
	_name.text = tr(message_data[current_message].name) if message_data[current_message].name != "%NICKNAME%" else Data.nickname
	_text.bbcode_text = tr(message_data[current_message].message)
	_text.percent_visible = 0.0
	_tween.interpolate_property(_text, "percent_visible", 0.0, 1.0, _text.text.length() / float(Data.char_per_seconds))
	
	if message_data[current_message].choices:
		_tween.interpolate_callback(self, _tween.get_runtime(), "create_choice_box", message_data[current_message].choices)
		
	else:
		_tween.interpolate_callback(self, _tween.get_runtime(), "set", "current_message", current_message + 1)
	
	_tween.start()


func _choice_selected(id : int):
	set_process_unhandled_input(true)
	current_message += 1
	advance_text()
	emit_signal("choice_selected", id)


func create_choice_box(choices : Array) -> void:
	var cb : MarginContainer = _choice_box.instance()
	
	set_process_unhandled_input(false)
	cb.connect("choice_selected", self, "_choice_selected")
	_list.add_child(cb)
	cb.add_buttons(choices)
	cb.show_choices()


func _ready():
	var tw := create_tween().set_ease(Tween.EASE_IN)
	
	modulate = Color(0, 0, 0, 0)
	tw.tween_property(self, "modulate", Color.white, 0.2)
	tw.tween_callback(self, "advance_text")
