extends Area2D

onready var _message_box := preload("res://src/ui/MessageBox.tscn")
onready var _canvas : CanvasLayer = get_tree().root.get_node("Main/CanvasLayer")

var messages := [
	{
		"name" : "Klishe's",
		"message" : "Hello! I' am [wave amp=50 freq=2]Klishe.[/wave]",
		"choices" : ["Hi!"]
	},
	{
		"name" : "Klishe's",
		"message" : "So you are in my test of dialogue box.",
		"choices" : []
	},
	{
		"name" : "Klishe's",
		"message" : "I realy hope this will works.",
		"choices" : []
	}
]


func _dialogue_finished(target : Node2D):
	target.set_process(true)


func action(target : Node2D) -> void:
	var box : Control = _message_box.instance()
	
	set_direction(global_position.direction_to(target.global_position))
	
	target.set_process(false)
	box.connect("message_finished", self, "_dialogue_finished", [target])
	box.message_data = messages
	
	_canvas.add_child(box)


func set_direction(direction : Vector2) -> void:
	match direction:
		Vector2.UP : pass
		Vector2.LEFT : pass
		Vector2.DOWN : pass
		Vector2.RIGHT : pass
