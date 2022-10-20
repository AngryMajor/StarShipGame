extends Node

onready var worldControler = GameState.world

var lableDict = {}

var theme = preload("res://General/MaineTheme.tres")

func render_tiles():
	worldControler.map_coords(funcref(self,"render_tile"))

func render_tile(coord):	
	var visual_data_array = worldControler.map_componnents("get_data",[coord])
	var text_data_dict = worldControler.map_componnents("get_text_for",[coord])
	var tile_index_dict = process_tile_data(visual_data_array)
	
	for child in get_children():
		if child.name != "Lables":
			if child.name in tile_index_dict:
				child.set_cellv(coord,tile_index_dict[child.name])
			else:
				child.set_cellv(coord,-1)
			
	var nonEmptyTextData = []
	for text in text_data_dict.values():
		if text != null and text != "":
			nonEmptyTextData.append(text)
			
	if nonEmptyTextData.size() > 0:
		create_text_box(nonEmptyTextData[0],coord)
	else:
		reset_text_box(coord)
		

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

func create_text_box(string:String, coord):
	if coord in lableDict:
		lableDict[coord].text = string.to_upper()
	else:
		var world_coords = worldControler.convert_map_to_world_coors(coord)
		var newLabel = Label.new() as Label
		newLabel.set_position(world_coords)
		newLabel.rect_size = Vector2(worldControler.TILE_SIZE,worldControler.TILE_SIZE)
		newLabel.valign = Label.VALIGN_BOTTOM
		newLabel.align = Label.ALIGN_CENTER
		newLabel.autowrap = true
		newLabel.text = string.to_upper()
		newLabel.theme = theme
		$Lables.add_child(newLabel)
		
		lableDict[coord] = newLabel

func reset_text_box(coord):
	if coord in lableDict:
		lableDict[coord].queue_free()
		lableDict.erase(coord)
