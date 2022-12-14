extends Node2D
class_name WorldController

onready var TILE_SIZE = $TileMaps/Main.cell_size.x

const MAP_SIZE_X = 16
const MAP_SIZE_Y = 14

const NORTH = Vector2(1,0)
const EAST =  Vector2(0,1)
const SOUTH =  Vector2(-1,0)
const WEST =  Vector2(0,-1)
const DIRECTIONS = [NORTH,EAST,SOUTH,WEST]

var regionMap : RegionMap setget ,get_regions
var resourceSys : RegionMap setget ,get_resources

func get_regions():
	return $RegionsMap
	
func get_resources():
	return $ResourceSys

func _enter_tree():
	GameState.world = self

func _ready():
	_set_up_children()
	$TileMaps.render_tiles()

func _set_up_children():
	for component in $Components.get_children():
		component.connect("data_updated",self,"on_tile_data_updated")


func on_tile_data_updated(coord):
	$TileMaps.render_tile(coord)

func convert_world_to_map_coors(world_coords):
	return (self.to_local(world_coords)/TILE_SIZE).floor()

func convert_map_to_world_coors(local_coords):
	return self.to_global(local_coords*TILE_SIZE)

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

func get_componnet(name:String):
	var componnent = null
	for child in $Components.get_children():
		if child.name == name:
			componnent = child
	return componnent

func map_componnents(functionName:String,args=[]) -> Dictionary:
	var returnMap = {}
	
	for child in $Components.get_children():
		if child.has_method(functionName):
			returnMap[child.name] = child.callv(functionName,args)
		else:
			returnMap[child.name] = null
	
	return returnMap
