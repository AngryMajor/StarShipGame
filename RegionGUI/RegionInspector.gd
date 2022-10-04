extends Control

func set_inspector(coords):
	var world = GameState.world
	var region_comp = world.get_componnet("RegionComp")
	var mission_comp = region_comp.get_componnet("MissionComp")
	var region = region_comp.get_region_id_for(coords)
	var data = region_comp.get_data_for(region)
	
	var missions_present = mission_comp.get_missions_in(region)
	
	$HBoxContainer/TileID.text = String(coords)
	$HBoxContainer/RegionID.text = String(region)
	$HBoxContainer/ArtNum.text = String(data["art_num"])
	$HBoxContainer/MissionID.text = String(missions_present.size())
