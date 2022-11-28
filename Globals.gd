extends Node

enum ItemsID {
	NONE = -1,
	GLASS_SHARD,
	UTILITY_ROOM_KEY,
	LAMP,
	CLEANING_ROOM_KEY,
	HANK_CRANK,
	FLOOR_2_KEY,
	HALLWAY_TOP_KEY,
	DORMITORY_KEY,
	RUSTY_KEY,
	CROWBAR,
	KLISHE_ROOM_KEY,
	MANSION_KEY
}

var ItemsData := {
	ItemsID.GLASS_SHARD : {
		"name" : "%GLASS_SHARD%",
		"description" : "%GLASS_SHARD_DESCRIPTION%"
	},
	ItemsID.UTILITY_ROOM_KEY : {
		"name" : "%UTILITY_ROOM_KEY%",
		"description" : "%UTILITY_ROOM_KEY_DESCRIPTION%"
	},
	ItemsID.LAMP : {
		"name" : "%LAMP%",
		"description" : "%LAMP_DESCRIPTION%"
	},
	ItemsID.CLEANING_ROOM_KEY : {
		"name" : "%CLEANING_ROOM_KEY%",
		"description" : "%CLEANING_ROOM_KEY_DESCRIPTION%"
	},
	ItemsID.HANK_CRANK : {
		"name" : "%HAND_CRANK%",
		"description" : "%HAND_CRANK_DESCRIPTION%"
	},
	ItemsID.FLOOR_2_KEY : {
		"name" : "%FLOOR_2_KEY%",
		"description" : "%FLOOR_2_KEY_DESCRIPTION%"
	},
	ItemsID.HALLWAY_TOP_KEY : {
		"name" : "%HALLWAY_TOP_KEY%",
		"description" : "%HALLWAY_TOP_KEY_DESCRIPTION%"
	},
	ItemsID.DORMITORY_KEY : {
		"name" : "%DORMITORY_KEY%",
		"description" : "%DORMITORY_KEY_DESCRIPTION%"
	},
	ItemsID.RUSTY_KEY : {
		"name" : "%RUSTY_KEY%",
		"description" : "%RUSTY_KEY_DESCRIPTION%"
	},
	ItemsID.CROWBAR : {
		"name" : "%CROWBAR%",
		"description" : "%CROWBAR_DESCRIPTION%"
	},
	ItemsID.KLISHE_ROOM_KEY : {
		"name" : "%KLISHE_ROOM_KEY_TAKE%",
		"description" : "%KLISHE_ROOM_KEY_DESCRIPTION%"
	},
	ItemsID.MANSION_KEY : {
		"name" : "%MANSION_KEY%",
		"description" : "%MANSION_KEY_DESCRIPTION%"
	}
}

enum LocationsID {
	ENTRANCE,
	CORRIDOR_RIGHT,
	KITCHEN,
	DINING_ROOM,
	CORRIDOR_LEFT,
	UTILITY_ROOM,
	STAIRCASE,
	BASEMENT_STAIRS,
	BASEMENT,
	DEPOSIT_ROOM_1,
	DEPOSIT_ROOM_2,
	DEPOSIT_ROOM_3,
	DEPOSIT_ROOM_4,
	DEPOSIT_ROOM_5,
	DEPOSIT_ROOM_6,
	DEPOSIT_ROOM_7,
	DEPOSIT_ROOM_8,
	CLEANING_ROOM,
	FLOOR_2_STAIRS,
	HALLWAY_BOTTOM,
	DORMITORY_1,
	DORMITORY_2,
	DORMITORY_3,
	DORMITORY_4,
	DORMITORY_5,
	DORMITORY_6,
	DORMITORY_7,
	PLAYROOM,
	BOTTOM_STORAGE_ROOM,
	LIVING_ROOM,
	OLD_ROOM,
	FLOOR_3_STAIRS,
	HALLWAY_TOP,
	ATTIC,
	TOP_STORAGE_ROOM,
	BATHROOM,
	RESTROOM,
	TOP_ATTIC,
	KLISHE_ROOM
}

var LocationsData := {
	LocationsID.ENTRANCE : {
		"name" : "%ENTRANCE%",
		"scene" : "res://src/rooms/Entrance.tscn"
	},
	LocationsID.CORRIDOR_LEFT : {
		"name" : "%CORRIDOR_LEFT%",
		"scene" : "res://src/rooms/CorridorLeft.tscn"
	},
	LocationsID.KITCHEN : {
		"name" : "%KITCHEN%",
		"scene" : "res://src/rooms/Kitchen.tscn"
	},
	LocationsID.DINING_ROOM : {
		"name" : "%DINING_ROOM%",
		"scene" : "res://src/rooms/DiningRoom.tscn"
	},
	LocationsID.CORRIDOR_RIGHT : {
		"name" : "%CORRIDOR_RIGHT%",
		"scene" : "res://src/rooms/CorridorRight.tscn"
	},
	LocationsID.UTILITY_ROOM : {
		"name" : "%UTILITY_ROOM%",
		"scene" : "res://src/rooms/UtilityRoom.tscn"
	},
	LocationsID.STAIRCASE : {
		"name" : "%STAIRCASE%",
		"scene" : "res://src/rooms/Staircase.tscn"
	},
	LocationsID.BASEMENT_STAIRS : {
		"name" : "%BASEMENT_STAIRS%",
		"scene" : "res://src/rooms/BasementStairs.tscn"
	},
	LocationsID.BASEMENT : {
		"name" : "%BASEMENT%",
		"scene" : "res://src/rooms/Basement.tscn"
	},
	LocationsID.DEPOSIT_ROOM_1 : {
		"name" : "%DEPOSIT_ROOM_1%",
		"scene" : "res://src/rooms/DepositRoom1.tscn"
	},
	LocationsID.DEPOSIT_ROOM_2 : {
		"name" : "%DEPOSIT_ROOM_2%",
		"scene" : "res://src/rooms/DepositRoom2.tscn"
	},
	LocationsID.DEPOSIT_ROOM_3 : {
		"name" : "%DEPOSIT_ROOM_3%",
		"scene" : "res://src/rooms/DepositRoom3.tscn"
	},
	LocationsID.DEPOSIT_ROOM_4 : {
		"name" : "%DEPOSIT_ROOM_4%",
		"scene" : "res://src/rooms/DepositRoom4.tscn"
	},
	LocationsID.DEPOSIT_ROOM_5 : {
		"name" : "%DEPOSIT_ROOM_5%",
		"scene" : "res://src/rooms/DepositRoom5.tscn"
	},
	LocationsID.DEPOSIT_ROOM_6 : {
		"name" : "%DEPOSIT_ROOM_6%",
		"scene" : "res://src/rooms/DepositRoom6.tscn"
	},
	LocationsID.DEPOSIT_ROOM_7 : {
		"name" : "%DEPOSIT_ROOM_7%",
		"scene" : "res://src/rooms/DepositRoom7.tscn"
	},
	LocationsID.DEPOSIT_ROOM_8 : {
		"name" : "%DEPOSIT_ROOM_8%",
		"scene" : "res://src/rooms/DepositRoom8.tscn"
	},
	LocationsID.CLEANING_ROOM : {
		"name" : "%CLEANING_ROOM%",
		"scene" : "res://src/rooms/CleaningRoom.tscn"
	},
	LocationsID.FLOOR_2_STAIRS : {
		"name" : "%FLOOR_2_STAIRS%",
		"scene" : "res://src/rooms/Floor2Stairs.tscn"
	},
	LocationsID.HALLWAY_BOTTOM : {
		"name" : "%HALLWAY_BOTTOM%",
		"scene" : "res://src/rooms/HallwayBottom.tscn"
	},
	LocationsID.DORMITORY_1 : {
		"name" : "%DORMITORY_1%",
		"scene" : "res://src/rooms/Dormitory1.tscn"
	},
	LocationsID.DORMITORY_2 : {
		"name" : "%DORMITORY_2%",
		"scene" : "res://src/rooms/Dormitory2.tscn"
	},
	LocationsID.DORMITORY_3 : {
		"name" : "%DORMITORY_3%",
		"scene" : "res://src/rooms/Dormitory3.tscn"
	},
	LocationsID.DORMITORY_4 : {
		"name" : "%DORMITORY_4%",
		"scene" : "res://src/rooms/Dormitory4.tscn"
	},
	LocationsID.DORMITORY_5 : {
		"name" : "%DORMITORY_5%",
		"scene" : "res://src/rooms/Dormitory5.tscn"
	},
	LocationsID.DORMITORY_6 : {
		"name" : "%DORMITORY_6%",
		"scene" : "res://src/rooms/Dormitory6.tscn"
	},
	LocationsID.DORMITORY_7 : {
		"name" : "%DORMITORY_7%",
		"scene" : "res://src/rooms/Dormitory7.tscn"
	},
	LocationsID.PLAYROOM : {
		"name" : "%PLAYROOM%",
		"scene" : "res://src/rooms/Playroom.tscn"
	},
	LocationsID.BOTTOM_STORAGE_ROOM : {
		"name" : "%BOTTOM_STORAGE_ROOM%",
		"scene" : "res://src/rooms/BottomStorage.tscn"
	},
	LocationsID.LIVING_ROOM : {
		"name" : "%LIVING_ROOM%",
		"scene" : "res://src/rooms/LivingRoom.tscn"
	},
	LocationsID.OLD_ROOM : {
		"name" : "%OLD_ROOM%",
		"scene" : "res://src/rooms/OldRoom.tscn"
	},
	LocationsID.FLOOR_3_STAIRS : {
		"name" : "%FLOOR_3_STAIRS%",
		"scene" : "res://src/rooms/Floor3Stairs.tscn"
	},
	LocationsID.HALLWAY_TOP : {
		"name" : "%HALLWAY_TOP%",
		"scene" : "res://src/rooms/HallwayTop.tscn"
	},
	LocationsID.ATTIC : {
		"name" : "%ATTIC%",
		"scene" : "res://src/rooms/Attic.tscn"
	},
	LocationsID.TOP_STORAGE_ROOM : {
		"name" : "%TOP_STORAGE_ROOM%",
		"scene" : "res://src/rooms/StorageRoom.tscn"
	},
	LocationsID.BATHROOM : {
		"name" : "%BATHROOM%",
		"scene" : "res://src/rooms/Bathroom.tscn"
	},
	LocationsID.RESTROOM : {
		"name" : "%RESTROOM%",
		"scene" : "res://src/rooms/Restroom.tscn"
	},
	LocationsID.TOP_ATTIC : {
		"name" : "%TOP_ATTIC%",
		"scene" : "res://src/rooms/TopAttic.tscn"
	},
	LocationsID.KLISHE_ROOM : {
		"name" : "%KLISHE_ROOM%",
		"scene" : "res://src/rooms/KlishesRoom.tscn"
	}
}

enum Languages {
	EN_US,
	PT_BR
}

func language_to_string(language : int) -> String:
	if language == Languages.EN_US : return "en_US"
	elif language == Languages.PT_BR : return "pt_BR"
	return ""


func string_to_language(language : String) -> int:
	if language == "en_US" : return Languages.EN_US
	elif language == "pt_BR" : return Languages.PT_BR
	return -1


func float_to_time(playtime : float) -> Dictionary:
	var time := {}
	
	time["miliseconds"] = str(playtime).split(".")[1].left(3)
	time["seconds"] = int(fmod(playtime, 60)) as String
	time["minutes"] = int(fmod(playtime, 3600) / 60) as String
	time["hours"] = int(fmod(playtime, 216000) / 3600 / 60) as String
	
	if time.seconds.length() == 1 : time.seconds = "0" + time.seconds
	if time.minutes.length() == 1 : time.minutes = "0" + time.minutes
	if time.hours.length() == 1 : time.hours = "0" + time.hours
	
	return time


func time_to_string(time : Dictionary, miliseconds : bool) -> String:
	var time_str := String(time.hours + ":" + time.minutes + ":" + time.seconds)
	
	if miliseconds:
		time_str += ":%s" % time.miliseconds
	
	return time_str


func set_volume(value : float) -> void:
	if value == 0 : value = -10000
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value / 10)
