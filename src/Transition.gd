extends ColorRect

signal finished

const DELAY := 0.35


func fade_in() -> void:
	var tween := create_tween().set_ease(Tween.EASE_OUT)
	
	color = Color(0.0, 0.0, 0.0, 0.0)
	tween.tween_property(self, "color", Color(0.0, 0.0, 0.0, 1.0), DELAY)
	tween.tween_callback(self, "emit_signal", ["finished"])


func fade_out() -> void:
	var tween := create_tween()
	
	color = Color(0.0, 0.0, 0.0, 1.0)
	tween.tween_property(self, "color", Color(0.0, 0.0, 0.0, 0.0), DELAY)
	tween.tween_callback(self, "emit_signal", ["finished"])
