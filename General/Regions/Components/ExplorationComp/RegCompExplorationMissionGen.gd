extends Node

onready var myRegion = $"../../"
onready var missionComp = GameState.world.get_componnet("MissionComp") as MissionComp
onready var explorationComp = $"../"

export(bool) var generate_exploration_missions = true

export(PackedScene) var startMission_scene
export(Array,PackedScene) var explorationMission_scenes
export(Array,PackedScene) var discoveryMission_scenes

export(int) var discoveryChance = 10
	
var sectorMissions : Array = []
	
func _ready():
	if generate_exploration_missions:
		call_deferred("_create_start_mission")
	
func _create_start_mission():
	var explorationMission = startMission_scene.instance()
	explorationMission.init(myRegion)
	missionComp.add_mission(myRegion.id,explorationMission)
	sectorMissions.append(explorationMission)
			
func generate_new_exploration_path(amount:int=1):
	if generate_exploration_missions == false:
		return 
	if amount <= 0:
		return
	for i in range(0,amount):
		var mission_index = rand_range(0,explorationMission_scenes.size())
		var explorationMission = explorationMission_scenes[mission_index].instance()
		explorationMission.init(myRegion)
		missionComp.add_mission(myRegion.id,explorationMission)
		sectorMissions.append(explorationMission)
	
func generate_new_discoveries(amount:int=1):
	if amount <= 0:
		return
	for i in range(0,amount):
		var mission_index = rand_range(0,discoveryMission_scenes.size())
		var discoveryMission = discoveryMission_scenes[mission_index].instance()
		discoveryMission.init(myRegion)
		missionComp.add_mission(myRegion.id,discoveryMission)
		sectorMissions.append(discoveryMission)
		
func clear_missions():
	for mission in sectorMissions:
		if is_instance_valid(mission) and mission != null:
			mission.abandon()
	
		


func _on_ShipManager_Region_empty():
	clear_missions()
	_create_start_mission()
