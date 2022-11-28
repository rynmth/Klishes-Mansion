extends Sprite

const SPEED := 1.0
const DELAY := 0.2
const MOVE := 3.1


func _ready():
	var tw := create_tween().set_loops()
	var dir := Vector2.LEFT.rotated(rotation)
	
	tw.tween_property(self, "global_position", global_position + dir * MOVE, SPEED)
	tw.tween_interval(DELAY)
	tw.tween_property(self, "global_position", global_position - dir * MOVE, SPEED)
	tw.tween_interval(DELAY)
