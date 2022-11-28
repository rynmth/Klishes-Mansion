extends Node2D

onready var _dialogue_box := preload("res://src/ui/MessageBox.tscn")
onready var _transition : ColorRect = $CanvasLayer/Transition
onready var _player : AnimatedSprite = $Player
onready var _ui : CanvasLayer = $CanvasLayer


func _ready():
	var dialogue_box := _dialogue_box.instance()
	
	_transition.fade_out()
	yield(_transition, "finished")
	dialogue_box.message_data = [
		load("res://src/dialogues/dream1.tres"),
		load("res://src/dialogues/dream2.tres"),
	]
	_ui.add_child(dialogue_box)
	yield(dialogue_box, "message_finished")
	_player.play("look")
	yield(_player, "animation_finished")
	_player.animation = "default"
	dialogue_box = _dialogue_box.instance()
	dialogue_box.message_data = [
		load("res://src/dialogues/dream3.tres"),
		load("res://src/dialogues/dream4.tres"),
		load("res://src/dialogues/dream5.tres")
	]
	_ui.add_child(dialogue_box)
	yield(dialogue_box, "message_finished")
	_transition.fade_in()
	yield(_transition, "finished")
	get_tree().change_scene("res://Main.tscn")
