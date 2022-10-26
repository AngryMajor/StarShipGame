extends MissionExecutor
class_name Ship

signal RequestToMoveTo(region)
signal Destroyed()

signal DataUpdated

export(int) var baseAP :int = 2
export(int) var currAP :int = 2 setget _set_curr_ap
export(int) var maxfuel :int = 3
var currFuel :int = 3 setget _set_curr_fuel

var route = []

var region : Region

func _set_curr_ap(value):
	currAP = value
	emit_signal("DataUpdated")

func _set_curr_fuel(value):
	currFuel = value
	emit_signal("DataUpdated")
	
func _enter_tree():
	GameState.connect("time_progressed",self,"on_time_progressed")
	
func _exit_tree():
	GameState.disconnect("time_progressed",self,"on_time_progressed")

func on_time_progressed(amount:int):
	var apSpent = self.baseAP - self.currAP
	if currFuel >= baseAP:
		self.currFuel -= apSpent
		self.currAP = self.baseAP
	elif currFuel > 0:
		self.currAP = self.currFuel
		self.currFuel = 0

func refuel():
	self.currFuel = self.maxfuel
	self.currAP = self.baseAP

func _ready():
	self.currFuel = self.maxfuel

func init(region):#TODO: shouldn't be init, is called whenever enting new region
	_enter_region(region)
	
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
	
func destroy():
	self.queue_free()
	if self.region != null:
		self.region.get_component("ShipManager").ship_leave(self)
	emit_signal("Destroyed")
	emit_signal("DataUpdated")
