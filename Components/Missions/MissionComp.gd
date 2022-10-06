extends Node
class_name MissionComp

signal data_updated
var missionScript = preload("res://Components/Missions/Mission.gd")
var mission_map = {}

onready var world = GameState.world

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
	_gen_new_mission()
	_gen_new_mission()
	_gen_new_mission()
	GameState.connect("time_progressed",self,"_on_time_progressed")
	
func _on_time_progressed(amount):
	_gen_new_mission()
	
func _gen_new_mission():
	var regionId = rand_range(0,6) as int
	Add_mission(regionId)
	
func Add_mission(regionID:int):
	var targetRegion :Region= world.regionMap.get_region(regionID)
	
	var coord = targetRegion.request_reserved_coord()
	if coord != null:
		var missionNode = Node.new()
		missionNode.set_script(missionScript)
		$MissionList.add_child(missionNode)
		mission_map[coord] = missionNode
		
		missionNode.connect("MissionComplete",self,"mission_freeing",[coord])
		missionNode.connect("MissionTimedOut",self,"mission_freeing",[coord])
		
		emit_signal("data_updated",coord)
		
func mission_freeing(mission,coord):
	mission_map.erase(coord)
	emit_signal("data_updated",coord)
	
