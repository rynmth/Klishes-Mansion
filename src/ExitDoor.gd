extends Area2D

onready var _transition : ColorRect = owner.get_node("UI/Transition")
onready var _dialogue_box := preload("res://src/ui/MessageBox.tscn")
onready var _ui : CanvasLayer = owner.get_node("UI")

var before_glass_shard := [
	load("res://src/dialogues/exit_bef_shard.tres")
]
var after_glass_shard := [
	load("res://src/dialogues/exit_aft_shard1.tres"),
	load("res://src/dialogues/exit_aft_shard2.tres")
]
var after_first_chase := [
	load("res://src/dialogues/exit_aft_chase.tres")
]
var exit_message := [
	load("res://src/dialogues/exit_final.tres")
]


func action(player : Area2D):
	if Data.get_meta("chased", false) and not Data.items.has(Globals.ItemsID.MANSION_KEY) : return
	player.set_process(false)
	
	var dialogue_box : Control = _dialogue_box.instance()
	
	if not Data.items.has(Globals.ItemsID.GLASS_SHARD):
		dialogue_box.message_data = before_glass_shard
		
	elif Data.items.has(Globals.ItemsID.MANSION_KEY):
		dialogue_box.message_data = exit_message
		Data.set_meta("no_spawn", true)
		if owner.get_node_or_null("Enemy") : get_node("Enemy").set_process(false)
		
	else:
		if Data.get_meta("chased", false) : return
		
		if not Data.first_chase:
			dialogue_box.message_data = after_glass_shard
			
		else:
			dialogue_box.message_data = after_first_chase
		
	_ui.add_child(dialogue_box)
	yield(dialogue_box, "message_finished")
	
	if Data.items.has(Globals.ItemsID.MANSION_KEY):
		_transition.fade_in()
		yield(_transition, "finished")
		if owner.get_node_or_null("Enemy") : get_node("Enemy").queue_free()
		Chase.stop()
		get_tree().change_scene("res://src/ui/End.tscn")
	
	if Data.items.has(Globals.ItemsID.GLASS_SHARD) and not Data.first_chase:
		owner.spawn_enemy(owner.get_node("TeleporterReceivers/SpawnShadow").position)
		Data.first_chase = true
	
	player.set_process(true)

