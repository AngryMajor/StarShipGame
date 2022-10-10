extends Node

onready var world := GameState.world 

func handel_input(event_dict):

	var coords = event_dict["tileCoords"]
	
	var missionComp :MissionComp = world.get_componnet("MissionComp")
	
	var mission = missionComp.mission_at(coords)
	
	if mission != null:
		mission.complete()
		
