extends Control

onready var _color : ColorRect = $ColorRect
onready var _resume : Button = $Buttons/VBoxContainer/Resume
onready var _save : Button = $Buttons/VBoxContainer/Save
onready var _load : Button = $Buttons/VBoxContainer/Load
onready var _config : Button = $Buttons/VBoxContainer/Config
onready var _buttons : CenterContainer = $Buttons
onready var _saves : CenterContainer = $Saves
onready var _options : CenterContainer = $Options
onready var _transition : ColorRect = get_parent().get_node("Transition")
onready var _swap_sfx : AudioStreamPlayer = $Swap
onready var _select_sfx : AudioStreamPlayer = $Select

enum LastButton {
	RESUME,
	SAVE,
	LOAD,
	CONFIG
}

onready var LastButtonData := {
	LastButton.SAVE : $Buttons/VBoxContainer/Save,
	LastButton.LOAD : $Buttons/VBoxContainer/Load,
	LastButton.CONFIG : $Buttons/VBoxContainer/Config
}

const SPEED := 0.2
var last_button : int = LastButton.RESUME
var img : Image
var player : Area2D


func _swap() : _swap_sfx.play()


func _selected() : _select_sfx.play()


func _open():
	var tw := create_tween().set_ease(Tween.EASE_OUT)
	
	img = get_viewport().get_texture().get_data()
	img.flip_y()
	
	show()
	tw.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 1.0), SPEED)
	tw.parallel().tween_property(_color, "color", Color(0.0, 0.0, 0.0, 0.8), SPEED)
	tw.tween_callback(self, "set_process", [true])
	tw.tween_callback(_resume, "grab_focus")


func close() -> void:
	var tw := create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN)
	
	_swap_sfx.play()
	tw.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), SPEED)
	tw.parallel().tween_property(_color, "color", Color(0.0, 0.0, 0.0, 0.0), SPEED)
	tw.tween_callback(self, "hide")
	tw.tween_callback(player, "set_process", [true])
	
	if get_focus_owner() : get_focus_owner().release_focus()
	set_process(false)


func _process(_delta : float):
	if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("open_menu"):
		close()


func _ready() : set_process(false)


func _on_Resume_pressed() : close()


func _on_Save_pressed():
	var tw := create_tween().set_ease(Tween.EASE_OUT)
	
	tw.tween_property(_buttons, "rect_global_position:x", -1080.0, SPEED)
	tw.parallel().tween_property(_saves, "rect_global_position:x", 0.0, SPEED)
	tw.tween_callback(_saves._slot1, "grab_focus")
	tw.tween_callback(_saves, "set_process", [true])
	
	_saves.save_type(_saves.SAVE)
	set_process(false)
	get_focus_owner().release_focus()
	last_button = LastButton.SAVE


func _on_Load_pressed():
	var tw := create_tween().set_ease(Tween.EASE_IN)
	
	tw.tween_property(_buttons, "rect_global_position:x", -1080.0, SPEED)
	tw.parallel().tween_property(_saves, "rect_global_position:x", 0.0, SPEED)
	tw.tween_callback(_saves._slot1, "grab_focus")
	tw.tween_callback(_saves, "set_process", [true])
	
	_saves.save_type(_saves.LOAD)
	set_process(false)
	get_focus_owner().release_focus()
	last_button = LastButton.LOAD


func _on_Options_pressed():
	var tw := create_tween().set_ease(Tween.EASE_IN)
	
	tw.tween_property(_buttons, "rect_global_position:x", -1080.0, SPEED)
	tw.parallel().tween_property(_options, "rect_global_position:x", 0.0, SPEED)
	tw.tween_callback(_options._text_speed, "grab_focus")
	tw.tween_callback(_options, "set_process", [true])
	
	set_process(false)
	get_focus_owner().release_focus()
	last_button = LastButton.CONFIG


func _on_Exit_pressed():
	_transition.fade_in()
	set_process(false)
	get_focus_owner().release_focus()
	yield(_transition, "finished")
	get_tree().change_scene("res://Main.tscn")


func _on_Options_cancel_pressed():
	var tw := create_tween().set_ease(Tween.EASE_IN)
	
	tw.tween_property(_buttons, "rect_global_position:x", 0.0, SPEED)
	tw.parallel().tween_property(_options, "rect_global_position:x", 1080.0, SPEED)
	tw.tween_callback(LastButtonData[last_button], "grab_focus")
	tw.tween_callback(self, "set_process", [true])


func _on_Saves_cancel_pressed():
	var tw := create_tween().set_ease(Tween.EASE_IN)
	
	tw.tween_property(_buttons, "rect_global_position:x", 0.0, SPEED)
	tw.parallel().tween_property(_saves, "rect_global_position:x", 1080.0, SPEED)
	tw.tween_callback(LastButtonData[last_button], "grab_focus")
	tw.tween_callback(self, "set_process", [true])


func _on_Saves_save_loaded():
	_transition.fade_in()
	set_process(false)
	get_focus_owner().release_focus()
	yield(_transition, "finished")
	Data.set_meta("load_game", true)
	get_tree().change_scene(Globals.LocationsData[Data.current_location].scene)
