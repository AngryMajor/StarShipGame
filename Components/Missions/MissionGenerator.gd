extends Node

export var mission_to_generate : Array
export var Mission_Comp : NodePath
onready var missionComp = get_node(Mission_Comp)

export(int) var minMissionsPerTurn : int = 1
export(int) var maxMissionsPerTurn : int = 3

func _enter_tree():
	GameState.connect("time_progressed",self,"_on_time_progressed")
	
func _exit_tree():
	GameState.disconnect("time_progressed",self,"_on_time_progressed")

func create_mission():
	var region_index = rand_range(0,6)
	missionComp.add_mission(region_index, _gen_mission())

func _gen_mission():
	var index = rand_range(0,mission_to_generate.size())
	var mission = mission_to_generate[index].instance()
	return mission

func _on_time_progressed(amount):
	for i in rand_range(minMissionsPerTurn,maxMissionsPerTurn):
		create_mission()
