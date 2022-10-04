extends Node

class_name RegionComponent

signal data_updated(coords)

export(PackedScene) var InspectorItem : PackedScene

var region_map = {}

func _ready():
	if $DataLoader != null:
		region_map = $DataLoader.get_data_coord_map()
		for coord in region_map.keys():
			region_map[coord] = [region_map[coord],RegionVisualSlot.new()]
			region_map[coord][1].connect("target_updated",self,"on_target_updated",[coord])
		
	var num_entities = $RegionList.get_child_count()
	for child in $Components.get_children():
		child.set_num_entities(num_entities)
		
	asign_slots_to_regions()

func on_target_updated(coord):
	emit_signal("data_updated",coord)
	
func get_slot_for(coords):
	return region_map[coords][1].target

func asign_slots_to_regions():
	for coord in region_map.keys():
		var region = $RegionList.get_child(region_map[coord][0])
		region.asign_slot(region_map[coord][1])

func get_inspector_pannel(coords):
	if not coords in region_map:
		return
	var inspectorPannel := InspectorItem.instance()
	inspectorPannel.set_inspector(coords)
	return inspectorPannel

func get_visual_data(coords:Vector2) -> Dictionary:
	var return_dict = {}

	if coords in region_map:
		return_dict["Region_index"] = region_map[coords][0]

	return return_dict
	

func get_data_for(region_id):
	if region_id >= 0 and $RegionList.get_child_count() > region_id:
		return $RegionList.get_child(region_id).get_data()
	else:
		return null

func get_region(region_id):
	if region_id >= 0 and $RegionList.get_child_count() > region_id:
		return $RegionList.get_child(region_id)
	else:
		return null

func get_region_id_for(coords):
	if coords in region_map:
		return region_map[coords][0]
	else:
		return null

func get_componnet(name:String):
	var componnent = null
	for child in $Components.get_children():
		if child.name == name:
			componnent = child
	return componnent
