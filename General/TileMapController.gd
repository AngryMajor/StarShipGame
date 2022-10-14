extends Node

onready var worldControler = GameState.world

func render_tiles():
	worldControler.map_coords(funcref(self,"render_tile"))

func render_tile(coord):	
	var visual_data_array = worldControler.map_componnents("get_data",[coord])
	var tile_index_dict = process_tile_data(visual_data_array)
	
	for child in get_children():
		if child.name in tile_index_dict:
			child.set_cellv(coord,tile_index_dict[child.name])
		else:
			child.set_cellv(coord,-1)

func process_tile_data(visual_data_array) -> Dictionary:
	var returnDict = {}
	for data in visual_data_array.values():
		if data != null:
			if "Mission" in data and data["Mission"] != null:
				returnDict["Main"] = 10 + data["Mission"].icon_index
			if "Ship" in data and data["Ship"] != null:
				returnDict["Main"] = 15
			if "Selected" in data and data["Selected"] != null:
				returnDict["Selection"] = 22
	return returnDict
