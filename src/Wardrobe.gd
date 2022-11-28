extends Area2D

onready var _transition := preload("res://src/Transition.tscn")
onready var _ui : CanvasLayer = owner.get_node("UI")
onready var _dialogue_box := preload("res://src/ui/MessageBox.tscn")
onready var _stream_player : AudioStreamPlayer = $AudioStreamPlayer

signal exit

var first_interaction := false


func action(player : Area2D):
	if Data.items.has(Globals.ItemsID.MANSION_KEY) : return
	if owner.get_node_or_null("Enemy") : return
	
	player.set_process(false)
	
	if not first_interaction and not Data.get_meta("chased", false):
		var dialogue_box := _dialogue_box.instance()
		
		dialogue_box.message_data = [load("res://src/dialogues/wardrober_first_interaction.tres")]
		_ui.add_child(dialogue_box)
		yield(dialogue_box, "message_finished")
	
	Data.set_meta("hidden", true)
	Data.first_wardrobe_interaction = true
	first_interaction = true
	
	var transition := _transition.instance()
	
	_ui.add_child(transition)
	transition.fade_in()
	_stream_player.play()
	yield(self, "exit")
	Data.set_meta("hidden", false)
	
	if Data.get_meta("chased", false):
		owner.emit_signal("shadow_continue")
	
	transition.fade_out()
	player.set_direction(Vector2.DOWN, true)
	_stream_player.play()
	yield(transition, "finished")
	transition.queue_free()
	player.set_process(true)


func _unhandled_input(event : InputEvent):
	if event is InputEventScreenTouch and event.pressed:
		emit_signal("exit")


func _process(_delta : float):
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("exit")


func _ready():
	first_interaction = Data.first_wardrobe_interaction
