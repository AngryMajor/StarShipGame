extends Node

export(NodePath) var _selection_map : NodePath
onready var selection_map = get_node(_selection_map)

func handel_input(event_dict):
	var coords = event_dict["tileCoords"]
	selection_map.set_highlighted_tiles([coords])
	
