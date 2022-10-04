extends Node

signal data_updated(coords)

export(PackedScene) var InspectorItem : PackedScene

func get_inspector_pannel(coords):
	var inspectorPannel := InspectorItem.instance()
	inspectorPannel.get_node("HBoxContainer/Label").text = String(coords)
	return inspectorPannel
						  
func get_visual_data(coords:Vector2) -> Dictionary:
	if int(coords.x + coords.y) % 2 == 1:
		var tileType = WorldController.TILE_TYPES.GRASS_TR
		return {"main":tileType}
	else:
		return {}
