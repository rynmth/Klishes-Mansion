extends Area2D

onready var _grid : TileMap = get_parent().get_node("Solid")
onready var _dialogue_box := preload("res://src/ui/MessageBox.tscn")
onready var _ui : CanvasLayer = owner.get_node("UI")


func _on_ActionDelimiter_area_entered(area : Area2D):
	if area.name != "Player" : return
	if Data.first_chase : return
	
	yield(area._anim_player, "animation_finished")
	
	var dialogue_box := _dialogue_box.instance()
	
	area.set_process(false)
	dialogue_box.message_data = [load("res://src/dialogues/start_limit.tres")]
	_ui.add_child(dialogue_box)
	yield(dialogue_box, "message_finished")
	
	area.set_direction(Vector2.RIGHT, false)
	area.move_to_grid(_grid.request_movement(self, Vector2.RIGHT))
