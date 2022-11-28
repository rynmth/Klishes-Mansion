extends MarginContainer

onready var _choice_scroll = $PanelContainer/MarginContainer/ScrollContainer
onready var _choice_list = $PanelContainer/MarginContainer/ScrollContainer/Choices

signal choice_selected(id)


func add_buttons(buttons : Array) -> void:
	for i in buttons.size():
		add_button(buttons[i], i)


func add_button(text : String, id : int) -> void:
	var button := Button.new()
	
	button.align = Button.ALIGN_RIGHT
	button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	button.text = text
	button.connect("pressed", self, "_choice_selected", [id])
	_choice_list.add_child(button)
	
	var btns = _choice_list.get_children()
	
	if btns.size() < 2: return
	
	btns[0].focus_neighbour_top = btns[-1].get_path()
	btns[0].focus_neighbour_bottom = btns[1].get_path()
	
	for i in range(1, _choice_list.get_child_count() - 1):
		btns[i].focus_neighbour_top = btns[i - 1].get_path()
		btns[i].focus_neighbour_bottom = btns[i + 1].get_path()
		
	btns[-1].focus_neighbour_top = btns[-2].get_path()
	btns[-1].focus_neighbour_bottom = btns[0].get_path()


func _choice_selected(id : int):
	var tw := create_tween().set_ease(Tween.EASE_OUT)
	
	tw.tween_property(self, "modulate", Color(0, 0, 0, 0), 0.2)
	tw.tween_callback(self, "emit_signal", ["choice_selected", id])
	tw.tween_callback(self, "queue_free")


func show_choices() -> void:
	var tw := create_tween().set_ease(Tween.EASE_IN)
	
	tw.tween_property(self, "modulate", Color.white, 0.2)
	_choice_list.get_children()[0].grab_focus()


func _ready():
	modulate = Color(0, 0, 0, 0)


func _on_ScrollContainer_sort_children():
	rect_min_size.y = 32 + _choice_list.get_parent().get_v_scrollbar().max_value
	rect_min_size.y = min(rect_min_size.y, 180)
