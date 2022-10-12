extends Node

signal data_updated 

var ship_map = {}

export var ship_scene : PackedScene

func get_data(coord):
	if ship_at(coord) == null:
		return {}
	else:
		return {"Ship":ship_at(coord)}
		
func ship_at(coord):
	if coord in ship_map:
		return ship_map[coord]
	else:
		return null

func _ready():
	var region = GameState.world.regionMap.get_region(0)

	for ship in $ShipList.get_children():
		add_ship(ship,region)

func add_ship(ship,region):
	if ship.get_parent() != $ShipList:
		$ShipList.add_child(ship)
	_put_ship_in_region(ship,region)
	ship.connect("RequestToMoveTo",self,"_move_ship_to",[ship])
	
	
func _put_ship_in_region(ship,region):
	var coord = region.request_reserved_coord()
	ship_map[coord] = ship
	ship.init(region)

	emit_signal("data_updated",coord)
	
func _remove_ship_from_its_region(ship):
	var ship_coord = get_ship_coord(ship)
	
	if ship_coord == null:
		return
	
	ship.region.release_reserved_coord(ship_coord)
	ship_map.erase(ship_coord)	
	emit_signal("data_updated",ship_coord)

func get_ship_coord(ship):	
	var keys = ship_map.keys()
	var i = 0
	var target = null
	
	while target == null and i < keys.size():
		if ship_map[keys[i]] == ship:
			target == ship
		else:
			i += 1
			
		if i == keys.size():
			push_error("tryed to find untracked ship")
			return null
		else:
			return keys[i]
	
func _move_ship_to(region:Region,ship:Ship):
	_remove_ship_from_its_region(ship)
	_put_ship_in_region(ship,region)
	
func get_ships():
	return $ShipList.get_children()
	
