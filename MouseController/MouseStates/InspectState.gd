extends Node


export(NodePath) var Inspector
onready var _inspector = get_node(Inspector) 

func handel_input(event_dict):
	var world := GameState.world 
	var coords = event_dict["tileCoords"]
	
	var pannel_array := world.map_componnents("get_inspector_pannel",[coords])
	_inspector.set_Inspector(pannel_array)
