extends Node
class_name MissionComp

signal data_updated
var missionScript = preload("res://Components/Missions/Mission.gd")
var mission_map = {}

onready var world := GameState.world

func get_data(coord):
	if mission_at(coord) == null:
		return {}
	else:
		return {"Mission":mission_at(coord)}

func mission_at(coord):
	if coord in mission_map:
		return mission_map[coord]
	else:
		return null

func _ready():
	GameState.connect("time_progressed",self,"_on_time_progressed")
	
func _on_time_progressed(amount):
	pass
	
func add_mission(regionID:int, missionNode):
	var targetRegion :Region= world.regionMap.get_region(regionID)
	
	var coord = targetRegion.request_reserved_coord()
	if coord != null:
		missionNode.init(targetRegion)
		$MissionList.add_child(missionNode)
		mission_map[coord] = missionNode
		
		missionNode.connect("MissionComplete",self,"mission_freeing",[coord])
		missionNode.connect("MissionTimedOut",self,"mission_freeing",[coord])
		
		emit_signal("data_updated",coord)
		
func mission_freeing(mission,coord):
	mission_map.erase(coord)
	emit_signal("data_updated",coord)
	
