extends Area2D

export (int) var id : int
onready var _sprite : Sprite = $Sprite
onready var _move : AudioStreamPlayer = $Move
onready var _correct : AudioStreamPlayer = $CorrectPassword

var enabled := false


func action(player : Area2D):
	if Data.basement_safer_unlocked : return
	
	player.set_process(false)
	enabled = not enabled
	_sprite.frame = int(not enabled)
	Data.set("deposit_lever_%d_enabled" % id, enabled)
	_move.play()
	yield(_move, "finished")
	
	var password := ""
	
	for i in range(1, 9):
		password += int(Data.get("deposit_lever_%d_enabled" % i)) as String
	
	if password == "01010111":
		_correct.play()
		Data.basement_safer_unlocked = true
		
	player.set_process(true)


func _ready():
	enabled = Data.get("deposit_lever_%d_enabled" % id)
	_sprite.frame = int(not enabled)
