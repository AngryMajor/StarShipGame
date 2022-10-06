extends TileMap
class_name RegionMap

onready var num_regions = $RegionList.get_child_count()
onready var world = GameState.world

func _ready():	
	_setup_region_coords()
	
func _setup_region_coords():
	world.map_coords(funcref(self,"_setup_coord"))

func _setup_coord(coord):
	var region := get_region_for(coord)
	if region != null:
		region._add_cord(coord)

func get_region_for(coord) -> Region:
	var index = get_cellv(coord)-16
	if index < 0 or index >= num_regions:
		return null
	else:
		return $RegionList.get_child(index) as Region

func map_regions(function:FuncRef, args=[]) -> Array:
	var returnArray = []
	
	args.push_front(null)
	for region in $RegionList.get_children():
		args[0] = region
		returnArray.append(function.call_func(args))
	
	return returnArray

func get_region(index : int) -> Region:
	return $RegionList.get_child(index) as Region
	return $RegionList.get_child(index) as Region
