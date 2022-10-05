extends Node
class_name Region


var MyCoords = []

func map_coords_in(function : FuncRef, args=[]):
	args.push_front(Vector2())
	for coord in MyCoords:
		args[0] = coord
		function.call_funcv(args)
