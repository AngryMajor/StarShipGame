extends Node

func handel_input(event_dict):
	var coords = event_dict["tileCoords"]
	var shipComp = GameState.world.get_componnet("ShipComp")
	var ship = shipComp.get_ships()[0]
	var missionControler = GameState.world.get_componnet("MissionComp") as MissionComp
	var missionAt = missionControler.mission_at(coords)
	if missionAt != null:
		ship.set_mission_target(missionAt)
	
	var region = GameState.world.regionMap.get_region_for(coords)
	ship.set_destination(region)
	
