extends Button

onready var _icon : TextureRect = $MarginContainer/HBoxContainer/TextureRect
onready var _location : Label = $MarginContainer/HBoxContainer/VBoxContainer/Location
onready var _playtime : Label = $MarginContainer/HBoxContainer/VBoxContainer/Playtime


func set_icon(image : Image) -> void:
	var texture := ImageTexture.new()
	
	texture.create_from_image(image)
	_icon.texture = texture


func set_location(location : String) -> void:
	_location.text = location


func set_playtime(playtime : String) -> void:
	_playtime.text = playtime


