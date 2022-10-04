extends Node

signal new_mission_available

export(Array) var MissionScenes

var rand = RandomNumberGenerator.new()

func _ready():
	GameState.connect("time_progressed",self,"on_time_progressed")
	
func set_num_entities(num):
	pass
	
func on_time_progressed(amount):
	emit_signal("new_mission_available")
	
func generate_new_mission() -> Node:
	var mission_index = rand.randi_range(0,MissionScenes.size()-1)
	var mission_node = MissionScenes[mission_index].instance()
	return mission_node
