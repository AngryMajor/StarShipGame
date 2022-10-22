extends Node
class_name MissionComp

signal data_updated
var missionScript = preload("res://Components/Missions/Mission.gd")
var mission_map = {}

onready var world := GameState.world

func _ready():
	GameState.connect("time_progressed",self,"_on_time_progressed")
	
func get_mission_coord(ship):	
	var keys = mission_map.keys()
	var i = 0
	var target = null
	
	while target == null and i < keys.size():
		if mission_map[keys[i]] == ship:
			target = ship
		else:
			i += 1
			
	if i >= keys.size():
		return null
	else:
		return keys[i]
	
func _on_time_progressed(amount):
	pass
	
func get_data(coord):
	if mission_at(coord) == null:
		return {}
	else:
		return {"Mission":mission_at(coord)}

func get_text_for(coord):
	if mission_at(coord) == null:
		return null
	else:
		return String(mission_at(coord).name)

func mission_at(coord):
	if coord in mission_map:
		return mission_map[coord]
	else:
		return null

func add_mission(regionID:int, missionNode):
	var targetRegion :Region= world.regionMap.get_region(regionID)
	
	var coord = targetRegion.request_reserved_coord()
	if coord != null:
		missionNode.init(targetRegion)
		$MissionList.add_child(missionNode)
		mission_map[coord] = missionNode
		
		missionNode.connect("DataUpdated",self,"_mission_updated",[coord])
		
		emit_signal("data_updated",coord)
		
		
func _mission_updated(mission:Mission,coord):
	if mission.get_parent() == null:
		_mission_freeing(mission,coord)
	emit_signal("data_updated",coord)
	
func _mission_freeing(mission:Mission,coord):
	mission_map.erase(coord)
	mission.region.release_reserved_coord(coord)

	
