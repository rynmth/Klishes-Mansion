extends CenterContainer

onready var _text_speed : HSlider = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/TextSpeed
onready var _text_speed_display : Label = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/TextSpeedDisplay
onready var _volume : HSlider = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/HBoxContainer/Volume
onready var _volume_display : Label = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/HBoxContainer/VolumeDisplay
onready var _swap_sfx : AudioStreamPlayer = $Swap
onready var _select_sfx : AudioStreamPlayer = $Select
onready var _auto_run : CheckBox = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/AutoRun
onready var language_buttons := {
	Globals.Languages.EN_US : get_node("PanelContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/VBoxContainer/EN_US"),
	Globals.Languages.PT_BR : get_node("PanelContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/VBoxContainer/PT_BR")
}

signal cancel_pressed


func _swap() : _swap_sfx.play()


func _selected() : _select_sfx.play()


func _process(_delta : float):
	if Input.is_action_just_pressed("ui_cancel"):
		get_focus_owner().release_focus()
		emit_signal("cancel_pressed")
		set_process(false)


func _ready():
	_text_speed.value = Data.char_per_seconds
	_volume.value = Data.volume
	language_buttons[Data.language].set_pressed_no_signal(true)
	_auto_run.set_pressed_no_signal(Data.auto_run)
	
	for key in language_buttons:
		var button : Button = language_buttons[key]
		
		if key == Data.language:
			button.disabled = true
	
	set_process(false)


func _on_TextSpeed_value_changed(value : int):
	_text_speed_display.text = str(value) + "c"
	Data.char_per_seconds = value
	Data.save_config()


func _on_Volume_value_changed(value : int):
	_volume_display.text = str(value) + "%"
	Globals.set_volume(value)
	Data.volume = value
	Data.save_config()


func _on_OptionButton_item_selected(index : int):
	Data.language = index
	Data.save_config()
	TranslationServer.set_locale(Globals.language_to_string(index))


func _on_EN_US_pressed():
	Data.language = Globals.Languages.EN_US
	Data.save_config()
	TranslationServer.set_locale(Globals.language_to_string(Globals.Languages.EN_US))
	language_buttons[Globals.Languages.PT_BR].set_pressed_no_signal(false)
	language_buttons[Globals.Languages.EN_US].disabled = true
	language_buttons[Globals.Languages.PT_BR].disabled = false


func _on_PT_BR_pressed():
	Data.language = Globals.Languages.PT_BR
	Data.save_config()
	TranslationServer.set_locale(Globals.language_to_string(Globals.Languages.PT_BR))
	language_buttons[Globals.Languages.EN_US].set_pressed_no_signal(false)
	language_buttons[Globals.Languages.PT_BR].disabled = true
	language_buttons[Globals.Languages.EN_US].disabled = false


func _on_AutoRun_pressed():
	Data.auto_run = not Data.auto_run
	Data.save_config()
