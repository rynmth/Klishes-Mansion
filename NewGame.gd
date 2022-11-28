extends CenterContainer

onready var _name_edit : LineEdit = $PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/NameEdit

var regex : RegEx


func _ready():
	regex = RegEx.new()
	regex.compile("[^a-z^A-Z ]")


func _on_NameEdit_text_changed(new_text : String):
	var result := regex.search(new_text)
	
	if result:
		var caret := _name_edit.caret_position - 1
		_name_edit.text = new_text.replace(result.get_string(), "")
		_name_edit.caret_position = caret
		return
	
	Data.nickname = new_text


func _on_Exit_pressed():
	Data.nickname = "The W"
	owner._transition.fade_in()
	yield(owner._transition, "finished")
	hide()
	owner._main_menu_container.show()
	owner._transition.fade_out()
	yield(owner._transition, "finished")
	owner._new_game.grab_focus()
