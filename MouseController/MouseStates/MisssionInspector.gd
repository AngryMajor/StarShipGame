extends Node


func handel_input(event_dict):
	var world := GameState.world 
	var coords = event_dict["tileCoords"]
	
	var region_comp :RegionComponent = world.get_componnet("RegionComp")
	var element = region_comp.get_slot_for(coords)
	var mission
	if element is Mission:
		mission = element
	if mission != null:
		mission.complete()
		
	GameState.progress_time(1)
