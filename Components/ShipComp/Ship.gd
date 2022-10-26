extends MissionExecutor
class_name Ship

signal RequestToMoveTo(region)

signal DataUpdated

export(int) var baseAP :int = 2
export(int) var currAP :int = 2 setget _set_curr_ap
export(int) var maxFule :int = 2
var currFule :int = 2 setget _set_curr_fule

var route = []

var region : Region

func _set_curr_ap(value):
	currAP = value
	emit_signal("DataUpdated")

func _set_curr_fule(value):
	currFule = value
	emit_signal("DataUpdated")
	
func _enter_tree():
	GameState.connect("time_progressed",self,"on_time_progressed")
	
func _exit_tree():
	GameState.disconnect("time_progressed",self,"on_time_progressed")

func on_time_progressed(amount:int):
	if currFule >= baseAP:
		self.currFule -= self.baseAP - self.currAP
		self.currAP = self.baseAP
	elif currFule > 0:
		self.currAP = self.currFule
		self.currFule = 0

func refule():
	self.currFule = self.maxFule
	self.currAP = self.baseAP

func init(region):
	_enter_region(region)
	self.currFule = self.maxFule
	
func _enter_region(region):
	if self.region != null:
		self.region.get_component("ShipManager").ship_leave(self)
	self.region = region
	if self.region != null:
		self.region.get_component("ShipManager").ship_enter(self)

func set_mission_target(mission:Mission):
	if currAP <= 0:
		return
	
	if mission.region == self.region:
		mission.execute(self)
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
