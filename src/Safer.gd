extends Area2D

onready var _dialogue_box := preload("res://src/ui/MessageBox.tscn")
onready var _write_pass := preload("res://src/ui/WritePassword.tscn")
onready var _ui : CanvasLayer = owner.get_node("UI")
onready var _pickup : AudioStreamPlayer = $Pickup
onready var _wrong : AudioStreamPlayer = $Wrong

signal check_finished

var digits : int
var is_open := false
var password := 79342


func _password_entered(passw : int):
	var dialogue_box := _dialogue_box.instance()
	
	dialogue_box.message_data = [load("res://src/dialogues/rusty_key_take.tres")] if passw == password else [load("res://src/dialogues/wrong_password.tres")]
	_ui.add_child(dialogue_box)
	
	if passw == password:
		is_open = true
		Data.items.append(Globals.ItemsID.RUSTY_KEY)
		_pickup.play()
		
	else : _wrong.play()
	
	yield(dialogue_box, "message_finished")
	emit_signal("check_finished")


func action(player : Area2D):
	player.set_process(false)
	
	if is_open:
		player.set_process(true)
		return
	
	var write := _write_pass.instance()
	
	_ui.add_child(write)
	write.connect("password_entered", self, "_password_entered")
	write.set_max_length(digits)
	yield(self, "check_finished")
	player.set_process(true)


func _ready():
	digits = str(password).length()
	is_open = Data.items.has(Globals.ItemsID.RUSTY_KEY)
