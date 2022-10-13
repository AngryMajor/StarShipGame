extends Node
class_name Ship

signal RequestToMoveTo(region)

signal DataUpdated

export(int) var baseAP :int = 2
export(int) var currAP :int = 2 setget _set_curr_ap

var route = []

var region : Region

func _set_curr_ap(value):
	currAP = value
	emit_signal("DataUpdated")

func _enter_tree():
	GameState.connect("time_progressed",self,"on_time_progressed")
	
func _exit_tree():
	GameState.disconnect("time_progressed",self,"on_time_progressed")

func on_time_progressed(amount:int):
	self.currAP = baseAP

func init(region):
	self.region = region

func set_mission_target(mission:Mission):
	if currAP <= 0:
		return
	
	if mission.region == self.region:
		mission.complete()
		self.currAP -= 1

func set_destination(destination:Region): 
	if currAP <= 0:
		return
	
	if self.region.adjacent_to(destination): 
		self.currAP -=1
		_move_to(destination)

func _move_to(region):
	emit_signal("RequestToMoveTo",region)
	emit_signal("DataUpdated")

#func on_time_progressed(amount:int):
#	if route.size() > 0:
#		_move_to(route[0])
#		route.remove(0)

#func set_destination(destination:Region):
#	route = []
#	if self.region.adjacent_to(destination):
#		route.append(destination)
#	else:
#		var intermidiaries = destination.neighbour_regions
#		var i = 0
#		var medium = null
#		while medium == null and i < intermidiaries.size(): #TODO: make building route recursize to any length
#			if self.region.adjacent_to(intermidiaries[i]):  
#				medium = intermidiaries[i]
#			i += 1
#
#		if medium != null:
#			route.append(medium)
#			route.append(destination)
#
#func _move_to(region):
#	emit_signal("RequestToMoveTo",region)

