extends Node


func handel_input(event_dict):
	var world := GameState.world 
	var regionComp = world.regionMap
	var coords = event_dict["tileCoords"]
	
	print_debug(regionComp.get_region_for(coords))
