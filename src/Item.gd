extends Area2D

export (Globals.ItemsID) var id := Globals.ItemsID.NONE
export (bool) var spawn_shadow := false
export (Array, Resource) var dialogue := []

onready var _dialogue_box := preload("res://src/ui/MessageBox.tscn")
onready var _ui : CanvasLayer = owner.get_node("UI")
onready var _stream_player : AudioStreamPlayer = $AudioStreamPlayer

var collected := false


func _dialogue_finished(player : Node2D):
	player.set_process(true)
	Data.items.append(id)
	collected = true
	
	if spawn_shadow:
		owner.spawn_enemy()
	
	hide()
	_stream_player.play()
	yield(_stream_player, "finished")
	queue_free()


func action(player : Area2D):
	if collected : return
	player.set_process(false)
	
	var dialogue_box : Control = _dialogue_box.instance()
	
	dialogue_box.connect("message_finished", self, "_dialogue_finished", [player])
	dialogue_box.message_data = dialogue
	
	_ui.add_child(dialogue_box)


func _ready():
	if Data.items.has(id):
		queue_free()
