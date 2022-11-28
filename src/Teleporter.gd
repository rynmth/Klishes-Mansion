extends Area2D

export (String, FILE, "*.tscn") var target : String
export (int, "Up", "Left", "Down", "Right") var look_direction : int
export (int) var id : int

var look_dirs := [
	Vector2.UP,
	Vector2.LEFT,
	Vector2.DOWN,
	Vector2.RIGHT
]


func _on_Teleporter_area_entered(player : Area2D):
	if not player.name == "Player" : return
	
	player.warping = true
	owner._transition.fade_in()
	yield(owner._transition, "finished")
	
	Data.set_meta("look_dir", look_dirs[look_direction])
	Data.set_meta("teleporter_id", id)
	
	get_tree().change_scene(target)
