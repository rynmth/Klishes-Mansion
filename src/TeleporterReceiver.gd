extends Position2D

export (int) var id : int


func _ready():
	add_to_group("teleporter_receiver")
