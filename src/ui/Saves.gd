extends CenterContainer

onready var _type : Label = $PanelContainer/MarginContainer/VBoxContainer/Type
onready var _slots : VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer
onready var _slot1 : Button = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/Slot1
onready var _transition := preload("res://src/Transition.tscn")
onready var _swap_sfx : AudioStreamPlayer = $Swap
onready var _select_sfx : AudioStreamPlayer = $Select

enum {
	SAVE,
	LOAD,
	CONTINUE
}

signal cancel_pressed
signal save_loaded

var for_save := false


func _swap() : _swap_sfx.play()


func _selected() : _select_sfx.play()


func save_type(type : int) -> void:
	match type:
		SAVE:
			for_save = true
			_type.text = tr("%SAVE_GAME%")
			
		LOAD:
			for_save = false
			_type.text = tr("%LOAD_GAME%")
			
		CONTINUE:
			for_save = false
			_type.text = tr("%CONTINUE_GAME%")


func _process(_delta : float):
	if Input.is_action_just_pressed("ui_cancel"):
		if get_focus_owner() : get_focus_owner().release_focus()
		emit_signal("cancel_pressed")
		set_process(false)


func _ready():
	var dir := Directory.new()
	var file := File.new()
	
	for slot in _slots.get_children():
		slot.connect("focus_entered", self, "_swap")
		slot.connect("pressed", self, "_selected")
	
	if not dir.dir_exists("user://saves"):
		dir.make_dir("user://saves")
	
	set_process(false)
	
	for i in range(1, _slots.get_child_count() + 1):
		if not dir.dir_exists("user://saves/slot%d" % i):
			dir.make_dir("user://saves/slot%d" % i)
		
		_slots.get_children()[i - 1].connect("pressed", self, "_slot_selected", [i])
		
		if file.file_exists("user://saves/slot%d/data.dat" % i):
			var icon := Image.new()
			
			file.open_compressed("user://saves/slot%d/data.dat" % i, File.READ, File.COMPRESSION_DEFLATE)
			icon.load("user://saves/slot%d/icon.png" % i)
			_slots.get_children()[i - 1].set_icon(icon)
			_slots.get_children()[i - 1].set_location(Globals.LocationsData[file.get_32()].name)
			_slots.get_children()[i - 1].set_playtime(Globals.time_to_string(Globals.float_to_time(file.get_float()), false))


func _slot_selected(slot : int):
	if for_save:
		var sl := _slots.get_node("Slot%d" % slot)
		
		sl.set_icon(owner.img)
		sl.set_location(Globals.LocationsData[Data.current_location].name)
		sl.set_playtime(Globals.time_to_string(Globals.float_to_time(Data.playtime), false))
		Data.save_data(slot, owner.img)
		
		return
	
	if Data.load_data(slot):
		Data.set_meta("chased", false)
		emit_signal("save_loaded")

