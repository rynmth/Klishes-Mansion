extends Control

onready var _color : ColorRect = $ColorRect
onready var _items : GridContainer = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/ScrollContainer/Items
onready var _item_display := preload("res://src/ui/ItemDisplay.tscn")
onready var _description : RichTextLabel = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/MarginContainer2/Description
onready var _swap_sfx : AudioStreamPlayer = $Swap

const SPEED := 0.2
var player : Area2D


func _swap() : _swap_sfx.play()


func _item_hover(id : int):
	_description.bbcode_text = tr(Globals.ItemsData[id].description)


func load_items() -> void:
	for item in _items.get_children():
		item.queue_free()
	
	yield(get_tree().create_timer(0.1), "timeout")
	
	for item in Data.items:
		var item_display := _item_display.instance()
		
		item_display.connect("focus_entered", self, "_item_hover", [item])
		item_display.connect("focus_entered", self, "_swap")
		
		item_display.id = item
		_items.add_child(item_display)
	
	if _items.get_children():
		_items.get_children()[0].grab_focus()


func _open():
	var tw := create_tween().set_ease(Tween.EASE_OUT)
	
	load_items()
	show()
	tw.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 1.0), SPEED)
	tw.parallel().tween_property(_color, "color", Color(0.0, 0.0, 0.0, 0.8), SPEED)
	tw.tween_callback(self, "set_process", [true])


func close() -> void:
	var tw := create_tween().set_ease(Tween.EASE_IN)
	
	_swap_sfx.play()
	tw.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), SPEED)
	tw.parallel().tween_property(_color, "color", Color(0.0, 0.0, 0.0, 0.0), SPEED)
	tw.tween_callback(self, "hide")
	tw.tween_callback(player, "set_process", [true])
	
	set_process(false)
	
	if get_focus_owner() : get_focus_owner().release_focus()


func _process(_delta : float):
	if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("open_inventory"):
		close()


func _ready() : set_process(false)
