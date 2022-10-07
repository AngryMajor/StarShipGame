extends BaseEffect

class_name PrintRegionEffect

export(String) var text = ""

func trigger(mission):
	.trigger(mission)
	var id = mission.region_id
	var region = GameState.world.regionComp.get_region(id)
	print_debug(text +" "+ String(region.name))
