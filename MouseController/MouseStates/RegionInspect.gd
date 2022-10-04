extends Node


func handel_input(event_dict):
	var world := GameState.world 
	var regionComp = world.get_componnet("RegionComp")
	var coords = event_dict["tileCoords"]
	
	print_debug(regionComp.get_region_id_for(coords))
