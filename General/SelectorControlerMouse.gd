extends Node

func handel_input(event_dict):	
	match event_dict["button"]:
		1:handel_left(event_dict)
		2:handel_right(event_dict)
	
	
func handel_right(event_dict):
	var coords = event_dict["tileCoords"]
	var shipComp = GameState.world.get_componnet("ShipComp")
	var target = GameState.selection
	var missionControler = GameState.world.get_componnet("MissionComp") as MissionComp
	var missionAt = missionControler.mission_at(coords)
	if target is Ship:
		if missionAt != null:
			target.set_mission_target(missionAt)
		else:
			var region = GameState.world.regionMap.get_region_for(coords)
			target.set_destination(region)
	
func handel_left(event_dict):
	var coords = event_dict["tileCoords"]
	var shipComp = GameState.world.get_componnet("ShipComp")
	var missionComp = GameState.world.get_componnet("MissionComp") as MissionComp
	var regionMap = GameState.world.regionMap as RegionMap
	
	if shipComp.ship_at(coords) != null:
		GameState.selection = shipComp.ship_at(coords)
	elif missionComp.mission_at(coords) != null:
		GameState.selection = missionComp.mission_at(coords)
	elif regionMap.get_region_for(coords) != null:
		GameState.selection = regionMap.get_region_for(coords)
	else:
		GameState.selection = null
