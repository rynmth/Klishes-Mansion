extends Control

onready var _transition : ColorRect = $Transition
onready var _main_menu_container : CenterContainer = $MainMenu
onready var _new_game : Button = $MainMenu/PanelContainer/MarginContainer/VBoxContainer/NewGame
onready var _continue : Button = $MainMenu/PanelContainer/MarginContainer/VBoxContainer/Continue
onready var _config : Button = $MainMenu/PanelContainer/MarginContainer/VBoxContainer/Config
onready var _quit : Button = $MainMenu/PanelContainer/MarginContainer/VBoxContainer/Quit
onready var _new_game_container : CenterContainer = $NewGame
onready var _saves_container : CenterContainer = $Saves
onready var _options_container : CenterContainer = $Options
onready var _name : Label = $MarginContainer/VBoxContainer/Label
onready var _swap_sfx : AudioStreamPlayer = $Swap
onready var _select_sfx : AudioStreamPlayer = $Select


func _swap() : _swap_sfx.play()


func _selected() : _select_sfx.play()


func _ready():
	if Chase.playing : Chase.stop()
	
	reset()
	_transition.fade_out()
	
	if OS.get_name() == "HTML5":
		_quit.disabled = true
	
	yield(_transition, "finished")
	_new_game.grab_focus()


func reset() -> void:
	Data.set_meta("no_spawn", false)
	Data.nickname = "Benjamin"
	Data.playing = false
	Data.playtime = 0.0
	Data.volume = 10
	Data.char_per_seconds = 40
	Data.last_position = Vector2.ZERO
	Data.last_direction = Vector2.ZERO
	Data.current_location = 0
	Data.items = []
	Data.unlocked_doors = []
	Data.first_time = true
	Data.first_chase = false
	Data.first_wardrobe_interaction = false
	Data.last_teleporter = Vector2.ZERO
	Data.utility_room_unlocked = false
	Data.deposit_lever_1_enabled = false
	Data.deposit_lever_2_enabled = false
	Data.deposit_lever_3_enabled = false
	Data.deposit_lever_4_enabled = false
	Data.deposit_lever_5_enabled = false
	Data.deposit_lever_6_enabled = false
	Data.deposit_lever_7_enabled = false
	Data.deposit_lever_8_enabled = false
	Data.basement_safer_unlocked = false
	Data.cleaning_room_unlocked = false
	Data.dining_room_unlocked = false
	Data.floor_2_unlocked = false
	Data.safe_box_unlocked = false
	Data.hallway_unlocked = false
	Data.lever_inside_playroom_enabled = false
	Data.cell_unlocked = false
	Data.lever_inside_cell_enabled = false
	Data.dorm_4_unlocked = false
	Data.dorm_5_unlocked = false
	Data.dorm_6_unlocked = false
	Data.dorm_7_unlocked = false
	Data.old_room_unlocked = false
	Data.valve_wheel_enabled = false
	Data.restroom_unlocked = false
	Data.bathroom_unlocked = false
	Data.klishe_room_unlocked = false


func _on_NewGame_pressed():
	_transition.fade_in()
	yield(_transition, "finished")
	_main_menu_container.hide()
	_name.hide()
	_new_game_container.show()
	_transition.fade_out()
	yield(_transition, "finished")
	_new_game_container._name_edit.grab_focus()
	_new_game_container._name_edit.caret_position = _new_game_container._name_edit.text.length()


func _on_Continue_pressed():
	_transition.fade_in()
	yield(_transition, "finished")
	_main_menu_container.hide()
	_name.hide()
	_saves_container.show()
	_saves_container.save_type(_saves_container.CONTINUE)
	_transition.fade_out()
	yield(_transition, "finished")
	_saves_container._slot1.grab_focus()
	_saves_container.set_process(true)


func _on_Config_pressed():
	_transition.fade_in()
	yield(_transition, "finished")
	_name.hide()
	_main_menu_container.hide()
	_options_container.show()
	_transition.fade_out()
	yield(_transition, "finished")
	_options_container._text_speed.grab_focus()
	_options_container.set_process(true)


func _on_Quit_pressed():
	_transition.fade_in()
	yield(_transition, "finished")
	get_tree().quit()


func _on_Options_cancel_pressed():
	_transition.fade_in()
	yield(_transition, "finished")
	_name.show()
	_options_container.hide()
	_main_menu_container.show()
	_transition.fade_out()
	yield(_transition, "finished")
	_config.grab_focus()
	_options_container.set_process(false)


func _on_Saves_cancel_pressed():
	_transition.fade_in()
	yield(_transition, "finished")
	_name.show()
	_saves_container.hide()
	_main_menu_container.show()
	_transition.fade_out()
	yield(_transition, "finished")
	_continue.grab_focus()
	_saves_container.set_process(false)


func _on_Saves_save_loaded():
	_transition.fade_in()
	set_process(false)
	get_focus_owner().release_focus()
	yield(_transition, "finished")
	Data.playing = true
	Data.set_meta("load_game", true)
	get_tree().change_scene(Globals.LocationsData[Data.current_location].scene)
