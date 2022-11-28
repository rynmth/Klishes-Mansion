extends Node2D

onready var _player : AnimatedSprite = $Player
onready var _gui : CanvasLayer = $CanvasLayer
onready var _goto : Position2D = $Goto
onready var _dialogue_box := preload("res://src/ui/MessageBox.tscn")

var start_messages := [
	load("res://src/dialogues/intro1.tres"),
	load("res://src/dialogues/intro2.tres"),
	load("res://src/dialogues/intro3.tres")
]
var end_messages := [
	load("res://src/dialogues/intro4.tres")
]


func _ready():
	var tween := create_tween()
	
	modulate = Color(0.0, 0.0, 0.0, 0.0)
	tween.tween_property(self, "modulate", Color.white, 1.0)
	yield(tween, "finished")
	
	var dialogue := _dialogue_box.instance()
	
	dialogue.message_data = start_messages
	_gui.add_child(dialogue)
	yield(dialogue, "message_finished")
	
	_player.animation = "walk"
	tween = create_tween()
	tween.tween_property(_player, "position", _goto.position, 2.5)
	tween.tween_callback(_player, "set", ["animation", "idle"])
	tween.tween_interval(0.5)
	yield(tween, "finished")
	
	dialogue = _dialogue_box.instance()
	dialogue.message_data = end_messages
	_gui.add_child(dialogue)
	yield(dialogue, "message_finished")
	
	tween = create_tween()
	tween.tween_property(self, "modulate", Color(0.0, 0.0, 0.0, 0.0), 1.0)
	yield(tween, "finished")
	
	Data.set_meta("look_dir", Vector2.UP)
	Data.set_meta("teleporter_id", 10)
	get_tree().change_scene("res://src/rooms/Entrance.tscn")
