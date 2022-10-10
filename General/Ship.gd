extends Node
class_name Ship

signal RequestToMoveTo(region)

var route = []

var region : Region

func _enter_tree():
	GameState.connect("time_progressed",self,"on_time_progressed")
	
func _exit_tree():
	GameState.disconnect("time_progressed",self,"on_time_progressed")

func on_time_progressed(amount:int):
	if route.size() > 0:
		_move_to(route[0])
		route.remove(0)

func init(region):
	self.region = region

func set_destination(destination:Region):
	route = []
	if self.region.adjacent_to(destination):
		route.append(destination)
	else:
		var intermidiaries = destination.neighbour_regions
		var i = 0
		var medium = null
		while medium == null and i < intermidiaries.size(): #TODO: make building route recursize to any length
			if self.region.adjacent_to(intermidiaries[i]):  
				medium = intermidiaries[i]
			i += 1
		
		if medium != null:
			route.append(medium)
			route.append(destination)
		
func _move_to(region):
	emit_signal("RequestToMoveTo",region)
