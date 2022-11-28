extends Button

onready var _icon : TextureRect = $MarginContainer/HBoxContainer/Icon
onready var _name : Label = $MarginContainer/HBoxContainer/Name

var id : int


func _ready():
	_icon.texture.region.position = Vector2(16 * id, 0)
	_name.text = tr(Globals.ItemsData[id].name)

