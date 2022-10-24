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
	if explorationMission == null or is_instance_valid(explorationMission) == false or explorationMission._completed:
		_create_new_exploration_mission()
		
func _create_new_exploration_mission():
	explorationMission = explorationMission_scene.instance()
	explorationMission.init(myRegion)
	missionComp.add_mission(myRegion.id,explorationMission)
	
func generate_anomaly():
	var anomalyMission = AnomalyMission_scene.instance()
	anomalyMission.init(myRegion)
	missionComp.add_mission(myRegion.id,anomalyMission)
