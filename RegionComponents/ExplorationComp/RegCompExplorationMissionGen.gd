extends Node

onready var myRegion = $"../../"
onready var missionComp = GameState.world.get_componnet("MissionComp") as MissionComp
onready var explorationComp = $"../"

export(Array,PackedScene) var explorationMission_scenes

export(Array,PackedScene) var discoveryMission_scenes

export(int) var discoveryChance = 10

func _enter_tree():
	GameState.connect("time_progressed",self,"_on_time_progressed")

func _exit_tree():
	GameState.disconnect("time_progressed",self,"_on_time_progressed")
	
func _ready():
	call_deferred("create_new_exploration_mission")
			
func create_new_exploration_mission():
	var mission_index = rand_range(0,explorationMission_scenes.size())
	var explorationMission = explorationMission_scenes[mission_index].instance()
	explorationMission.init(myRegion)
	missionComp.add_mission(myRegion.id,explorationMission)
	
func generate_discovery():
	var mission_index = rand_range(0,discoveryMission_scenes.size())
	var discoveryMission = discoveryMission_scenes[mission_index].instance()
	discoveryMission.init(myRegion)
	missionComp.add_mission(myRegion.id,discoveryMission)
