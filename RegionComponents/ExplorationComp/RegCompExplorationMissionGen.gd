extends Node

onready var myRegion = $"../../"
onready var missionComp = GameState.world.get_componnet("MissionComp") as MissionComp
onready var explorationComp = $"../"

export(PackedScene) var explorationMission_scene
var explorationMission :Node = null

export(PackedScene) var AnomalyMission_scene


export(int) var anomalyChance = 10

func _enter_tree():
	GameState.connect("time_progressed",self,"_on_time_progressed")

func _exit_tree():
	GameState.disconnect("time_progressed",self,"_on_time_progressed")
	
func _on_time_progressed(amount):
	if explorationMission == null or is_instance_valid(explorationMission) == false:
		_create_new_exploration_mission()
		
	if int(rand_range(0,100)) < anomalyChance:
		_create_new_anomaly_mission()

func _create_new_exploration_mission():
	explorationMission = explorationMission_scene.instance()
	explorationMission.init(myRegion)
	missionComp.add_mission(myRegion.id,explorationMission)
	
func _create_new_anomaly_mission():
	var mission = AnomalyMission_scene.instance()
	mission.init(myRegion)
	missionComp.add_mission(myRegion.id, mission)
