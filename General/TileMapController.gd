extends Node

onready var worldControler = GameState.world

func render_tiles():
	worldControler.map_coords(funcref(self,"_render_tile"))

func _render_tile(coord):	
	var visual_data_array = worldControler.map_componnents("get_visual_data",[coord])
	var tile_index_dict = process_tile_data(visual_data_array)
	
	for child in get_children():
		if child.name in tile_index_dict:
			child.set_cellv(coord,tile_index_dict[child.name])
		else:
			child.set_cellv(coord,-1)



func process_tile_data(visual_data_array) -> Dictionary:
	var returnDict = {}
	for data in visual_data_array:
		if data != null:
			if "Region_index" in data and data["Region_index"] != -1:
				returnDict["Regions"] = data["Region_index"] +16
			if "Mission" in data and data["Mission"] != null:
				returnDict["Main"] = 10
	return returnDict
