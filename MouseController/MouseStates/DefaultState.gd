extends Node


func handel_input(event_dict):
	var tile_coords = event_dict["tileCoords"]
	var tile = GameState.world.get_tile(tile_coords)
	print_debug("state" + String(tile))
