extends Control

onready var _transition : ColorRect = $Transition
onready var _continue : Button = $Main/CenterContainer/VBoxContainer/Continue
onready var _main : Control = $Main
onready var _saves : CenterContainer = $Saves
onready var _stream_player : AudioStreamPlayer = $AudioStreamPlayer


func _ready():
	if Chase.playing : Chase.stop()
	_stream_player.play()
	_transition.fade_out()
	yield(_transition, "finished")
	_continue.grab_focus()


func _on_Continue_pressed():
	_transition.fade_in()
	yield(_transition, "finished")
	_main.hide()
	_saves.show()
	_saves.save_type(_saves.CONTINUE)
	_transition.fade_out()
	yield(_transition, "finished")
	_saves._slot1.grab_focus()
	_saves.set_process(true)


func _on_Exit_pressed():
	_transition.fade_in()
	yield(_transition, "finished")
	get_tree().change_scene("res://Main.tscn")


func _on_Saves_cancel_pressed():
	_transition.fade_in()
	yield(_transition, "finished")
	_saves.hide()
	_main.show()
	_transition.fade_out()
	yield(_transition, "finished")
	_continue.grab_focus()
	_saves.set_process(false)


func _on_Saves_save_loaded():
	_transition.fade_in()
	set_process(false)
	get_focus_owner().release_focus()
	yield(_transition, "finished")
	Data.set_meta("load_game", true)
	get_tree().change_scene(Globals.LocationsData[Data.current_location].scene)
