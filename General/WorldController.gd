extends Node2D
class_name WorldController

onready var TILE_SIZE = $TileMaps/Main.cell_size.x

const MAP_SIZE_X = 64
const MAP_SIZE_Y = 64

onready var _tilemaps = $TileMaps
onready var _components = $Components

var regionMap : RegionMap setget ,get_regions

func get_regions():
	return $RegionsMap


func _enter_tree():
	GameState.world = self

func _ready():
	_set_up_children()
	_tilemaps.render_tiles()


func _set_up_children():
	for component in _components.get_children():
		component.connect("data_updated",self,"on_tile_data_updated")

func on_tile_data_updated(coord):
	_tilemaps.render_tile(coord)

func map_coords(function:FuncRef,tileRangeLower=null,tileRangeUpper=null, args=[]) -> Array:
	var returnArray = []

	if tileRangeUpper == null:
		tileRangeUpper = Vector2(MAP_SIZE_X,MAP_SIZE_Y)
	if tileRangeLower == null:
		tileRangeLower = Vector2(0,0)

	args.push_front(Vector2())
	
	for y in range(tileRangeLower.y,tileRangeUpper.y):
		returnArray.append([])
		for x in range(tileRangeLower.x,tileRangeUpper.x):
			args[0] = Vector2(x,y)
			returnArray[returnArray.size()-1].append(function.call_funcv(args))

	return returnArray

func map_componnents(functionName:String,args=[]) -> Dictionary:
	var returnMap = {}
	
	for child in _components.get_children():
		if child.has_method(functionName):
			returnMap[child.name] = child.callv(functionName,args)
		else:
			returnMap[child.name] = null
	
	return returnMap

func convert_world_to_map_coors(world_coords):
	return (self.to_local(world_coords)/TILE_SIZE).floor()
	
func get_tile(coords):
	var return_map = {}
	for tilemap in _tilemaps.get_children():
		if tilemap.get_cellv(coords) == -1:
			return_map[tilemap.name] = -1
		else:
			return_map[tilemap.name] = tilemap.get_cellv(coords)
	
	return return_map

func get_componnet(name:String):
	var componnent = null
	for child in _components.get_children():
		if child.name == name:
			componnent = child
	return componnent
		
