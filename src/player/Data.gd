extends Node

var nickname := "Benjamin"
var playing := false
var playtime := 0.0
var volume := 10
var char_per_seconds := 40
var language := -1
var last_position := Vector2.ZERO
var last_direction := Vector2.ZERO
var current_location := 0
var items := []
var unlocked_doors := []
var first_time := true
var first_chase := false
var first_wardrobe_interaction := false
var last_teleporter := Vector2.ZERO
var utility_room_unlocked := false
var deposit_lever_1_enabled := false
var deposit_lever_2_enabled := false
var deposit_lever_3_enabled := false
var deposit_lever_4_enabled := false
var deposit_lever_5_enabled := false
var deposit_lever_6_enabled := false
var deposit_lever_7_enabled := false
var deposit_lever_8_enabled := false
var basement_safer_unlocked := false
var cleaning_room_unlocked := false
var dining_room_unlocked := false
var floor_2_unlocked := false
var safe_box_unlocked := false
var hallway_unlocked := false
var lever_inside_playroom_enabled := false
var cell_unlocked := false
var lever_inside_cell_enabled := false
var dorm_4_unlocked := false
var dorm_5_unlocked := false
var dorm_6_unlocked := false
var dorm_7_unlocked := false
var old_room_unlocked := false
var valve_wheel_enabled := false
var restroom_unlocked := false
var bathroom_unlocked := false
var klishe_room_unlocked := false


func _unhandled_input(event : InputEvent):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_F11:
			OS.window_fullscreen = not OS.window_fullscreen


func _process(delta : float):
	if not playing : return
	
	playtime += delta


func save_config() -> void:
	var file := File.new()
	
	file.open_compressed("user://config.dat", File.WRITE, File.COMPRESSION_DEFLATE)
	file.store_32(volume)
	file.store_32(char_per_seconds)
	file.store_64(language)
	file.close()


func load_config() -> void:
	var file := File.new()
	var error := file.open_compressed("user://config.dat", File.READ, File.COMPRESSION_DEFLATE)
	
	if error != OK : return
	
	volume = file.get_32()
	char_per_seconds = file.get_32()
	language = file.get_64()
	file.close()


func save_data(slot : int, texture : Image) -> void:
	var file := File.new()
	
	file.open_compressed("user://saves/slot%d/data.dat" % slot, File.WRITE, File.COMPRESSION_DEFLATE)
	file.store_32(current_location)
	file.store_float(playtime)
	file.store_pascal_string(nickname)
	
	if get_meta("from_pos", true):
		last_position = get_meta("scene_pos")
		last_direction = get_meta("scene_look")
	
	file.store_float(last_position.x)
	file.store_float(last_position.y)
	file.store_float(last_direction.x)
	file.store_float(last_direction.y)
	file.store_32(items.size())
	for i in items.size() : file.store_32(items[i])
	file.store_32(unlocked_doors.size())
	for i in unlocked_doors.size() : file.store_32(unlocked_doors[i])
	file.store_32(int(first_time))
	file.store_32(int(first_chase))
	file.store_32(int(first_wardrobe_interaction))
	file.store_float(last_teleporter.x)
	file.store_float(last_teleporter.y)
	file.store_32(int(utility_room_unlocked))
	file.store_32(int(deposit_lever_1_enabled))
	file.store_32(int(deposit_lever_2_enabled))
	file.store_32(int(deposit_lever_3_enabled))
	file.store_32(int(deposit_lever_4_enabled))
	file.store_32(int(deposit_lever_5_enabled))
	file.store_32(int(deposit_lever_6_enabled))
	file.store_32(int(deposit_lever_7_enabled))
	file.store_32(int(deposit_lever_8_enabled))
	file.store_32(int(basement_safer_unlocked))
	file.store_32(int(cleaning_room_unlocked))
	file.store_32(int(dining_room_unlocked))
	file.store_32(int(floor_2_unlocked))
	file.store_32(int(safe_box_unlocked))
	file.store_32(int(hallway_unlocked))
	file.store_32(int(lever_inside_playroom_enabled))
	file.store_32(int(cell_unlocked))
	file.store_32(int(lever_inside_cell_enabled))
	file.store_32(int(dorm_4_unlocked))
	file.store_32(int(dorm_5_unlocked))
	file.store_32(int(dorm_6_unlocked))
	file.store_32(int(dorm_7_unlocked))
	file.store_32(int(old_room_unlocked))
	file.store_32(int(valve_wheel_enabled))
	file.store_32(int(restroom_unlocked))
	file.store_32(int(bathroom_unlocked))
	file.store_32(int(klishe_room_unlocked))
	
	texture.save_png("user://saves/slot%d/icon.png" % slot)
	file.close()


func load_data(slot : int) -> bool:
	var file := File.new()
	var error := file.open_compressed("user://saves/slot%d/data.dat" % slot, File.READ, File.COMPRESSION_DEFLATE)
	
	if error != OK : return false
	
	items.clear()
	unlocked_doors.clear()
	
	current_location = file.get_32()
	playtime = file.get_float()
	nickname = file.get_pascal_string()
	last_position = Vector2(file.get_float(), file.get_float())
	last_direction = Vector2(file.get_float(), file.get_float())
	for i in file.get_32() : items.append(file.get_32())
	for i in file.get_32() : unlocked_doors.append(file.get_32())
	first_time = bool(file.get_32())
	first_chase = bool(file.get_32())
	first_wardrobe_interaction = bool(file.get_32())
	last_teleporter = Vector2(file.get_float(), file.get_float())
	utility_room_unlocked = bool(file.get_32())
	deposit_lever_1_enabled = bool(file.get_32())
	deposit_lever_2_enabled = bool(file.get_32())
	deposit_lever_3_enabled = bool(file.get_32())
	deposit_lever_4_enabled = bool(file.get_32())
	deposit_lever_5_enabled = bool(file.get_32())
	deposit_lever_6_enabled = bool(file.get_32())
	deposit_lever_7_enabled = bool(file.get_32())
	deposit_lever_8_enabled = bool(file.get_32())
	basement_safer_unlocked = bool(file.get_32())
	cleaning_room_unlocked = bool(file.get_32())
	dining_room_unlocked = bool(file.get_32())
	floor_2_unlocked = bool(file.get_32())
	safe_box_unlocked = bool(file.get_32())
	hallway_unlocked = bool(file.get_32())
	lever_inside_playroom_enabled = bool(file.get_32())
	cell_unlocked = bool(file.get_32())
	lever_inside_cell_enabled = bool(file.get_32())
	dorm_4_unlocked = bool(file.get_32())
	dorm_5_unlocked = bool(file.get_32())
	dorm_6_unlocked = bool(file.get_32())
	dorm_7_unlocked = bool(file.get_32())
	old_room_unlocked = bool(file.get_32())
	valve_wheel_enabled = bool(file.get_32())
	restroom_unlocked = bool(file.get_32())
	bathroom_unlocked = bool(file.get_32())
	klishe_room_unlocked = bool(file.get_32())
	
	file.close()
	return true


func _ready():
	load_config()
	
	if Data.language == -1:
		Data.language = Globals.string_to_language(OS.get_locale())
		
		if Data.language == -1:
			TranslationServer.set_locale("en_US")
			Data.language = Globals.Languages.EN_US
			
		else : TranslationServer.set_locale(Globals.language_to_string(Data.language))
			
	else:
		TranslationServer.set_locale(Globals.language_to_string(Data.language))
		Data.language = Globals.string_to_language(TranslationServer.get_locale())
		
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
