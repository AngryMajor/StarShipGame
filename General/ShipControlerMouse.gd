extends Node

func handel_input(event_dict):
	match event_dict["button"]:
		1:handel_left(event_dict)
		2:handel_right(event_dict)
	
func handel_right(event_dict):
	var coords = event_dict["tileCoords"]
	var shipComp = GameState.world.get_componnet("ShipComp")
	var ship = GameState.selectedShip
	var missionControler = GameState.world.get_componnet("MissionComp") as MissionComp
	var missionAt = missionControler.mission_at(coords)
	if missionAt != null:
		ship.set_mission_target(missionAt)
	else:
		var region = GameState.world.regionMap.get_region_for(coords)
		ship.set_destination(region)
	
func handel_left(event_dict):
	var coords = event_dict["tileCoords"]
	var shipComp = GameState.world.get_componnet("ShipComp")
	
	if shipComp.ship_at(coords) != null:
		GameState.selectedShip = shipComp.ship_at(coords)
