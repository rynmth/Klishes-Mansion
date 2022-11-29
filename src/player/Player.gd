extends Area2D

onready var _tween : Tween = $Tween
onready var _ray : RayCast2D = $RayCast2D
onready var _anim_player : AnimationPlayer = $AnimationPlayer
onready var _grid : TileMap = get_parent().get_node("Solid")
onready var _ui : CanvasLayer = get_parent().get_node("UI")
onready var _light : Light2D = $Light2D

signal open_inventory
signal open_menu

const WALK_SPEED := 1.0
const SPRINT_SPEED := 2.0

var warping := false


func _process(_delta : float):
	var move := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).ceil()
	
	var speed := SPRINT_SPEED if Input.is_action_pressed("ui_cancel") else WALK_SPEED
	if Data.auto_run : speed = SPRINT_SPEED
	
	if Data.first_time : return
	
	if Input.is_action_just_pressed("open_inventory") and not Data.get_meta("chased", false):
		emit_signal("open_inventory")
		set_process(false)
	
	if Input.is_action_just_pressed("open_menu") and not Data.get_meta("chased", false):
		emit_signal("open_menu")
		set_process(false)
	
	if _ray.is_colliding() and Input.is_action_just_pressed("ui_accept"):
		var obj : Node2D = _ray.get_collider()
		
		if obj : if obj.has_method("action"):
			obj.action(self)
	
	if not move or warping: return
	if move.length() > 1 : move.x = 0
	
	_anim_player.playback_speed = speed
	
	var dir : Vector2 = _grid.request_movement(self, move)
	
	if dir:
		set_direction(move, false)
		move_to_grid(dir)
		return
		
	set_direction(move, true)


func set_direction(direction : Vector2, idle : bool) -> void:
	Data.last_direction = direction
	_ray.rotation = direction.angle()
	
	match direction:
		Vector2.UP : _anim_player.play("idle_up" if idle else "walk_up")
		Vector2.LEFT : _anim_player.play("idle_left" if idle else "walk_left")
		Vector2.DOWN : _anim_player.play("idle_down" if idle else "walk_down")
		Vector2.RIGHT : _anim_player.play("idle_right" if idle else "walk_right")


func move_to_grid(target : Vector2) -> void:
	set_process(false)
	
	_tween.interpolate_property(
		self, "position", position, target,
		_anim_player.current_animation_length / _anim_player.playback_speed,
		Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	_tween.start()
	
	yield(_anim_player, "animation_finished")
	set_process(true)
	Data.last_position = global_position


func _ready():
	var inventory := _ui.get_node("Inventory")
	var menu := _ui.get_node("Menu")
	
	inventory.player = self
	menu.player = self
	
	connect("open_inventory", inventory, "_open")
	connect("open_menu", menu, "_open")
	
	global_position = _grid.map_to_world(_grid.world_to_map(global_position)) + _grid.cell_size / 2
