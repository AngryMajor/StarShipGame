extends Node

func handel_input(event_dict):
	var coords = event_dict["tileCoords"]
	var region = GameState.world.regionMap.get_region_for(coords)
	var shipComp = GameState.world.get_componnet("ShipComp")
	var ship = shipComp.get_ships()[0]
	ship.set_destination(region)
	
