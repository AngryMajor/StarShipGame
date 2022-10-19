extends Node
class_name Region

onready var id = self.get_index()
var unreservedCoords = []
var reservedCoords = []

var neighbour_regions = []


func map_coords_in(function : FuncRef, args=[]) -> Array:
	var returnArray = []
	args.push_front(Vector2())
	for coord in unreservedCoords:
		args[0] = coord
		var returnValue = function.call_funcv(args)
		if returnValue != null:
			returnArray.append(returnValue)
	for coord in reservedCoords:
		args[0] = coord
		var returnValue = function.call_funcv(args)
		if returnValue != null:
			returnArray.append(returnValue)
	return returnArray

func _add_cord(coord):
	unreservedCoords.append(coord)

func _add_neighbour_region(region:Region):
	if region != null and not region in neighbour_regions:
		neighbour_regions.append(region)

func request_reserved_coord():
	if unreservedCoords.size() == 0:
		return null
	else:
		var targetCoord = unreservedCoords[0]
		unreservedCoords.remove(0)
		reservedCoords.append(targetCoord)
		return targetCoord

func release_reserved_coord(coord):
	var index = reservedCoords.find(coord)
	reservedCoords.remove(index)
	unreservedCoords.append(coord)

func get_component(name:String):
	for child in self.get_children():
		if child.name == name:
			return child
	return null

func map_components(function : FuncRef, args=[]):
	var returnArray = []
	args.push_front(null)
	for comp in self.get_children():
		args[0] = comp
		var returnValue = function.call_funcv(args)
		if returnValue != null:
			returnArray.append(returnValue)
	return returnArray


func adjacent_to(other:Region):
	return other in neighbour_regions
