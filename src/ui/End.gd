extends Control

onready var _dialogue_box := preload("res://src/ui/MessageBox.tscn")

var messages := [
	load("res://src/dialogues/end1.tres"),
	load("res://src/dialogues/end2.tres"),
	load("res://src/dialogues/end3.tres")
]


func _ready():
	var dialogue_box := _dialogue_box.instance()
	
	dialogue_box.message_data = messages
	add_child(dialogue_box)
	yield(dialogue_box, "message_finished")
	get_tree().change_scene("res://src/rooms/MyRoom.tscn")


