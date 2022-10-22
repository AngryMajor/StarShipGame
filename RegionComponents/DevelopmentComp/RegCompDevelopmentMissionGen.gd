extends Node

export(int) var eventChance = 10

onready var myRegion = $"../../"
onready var missionComp = GameState.world.get_componnet("MissionComp") as MissionComp
onready var developmentComp = $"../"


func _enter_tree():
	GameState.connect("time_progressed",self,"_check_for_event")

func _exit_tree():
	GameState.disconnect("time_progressed",self,"_check_for_event")
	
func _check_for_event(amount):
	if rand_range(0,100) < eventChance:
		var missionRoll = rand_range(0,100) + developmentComp.totalDevelopment
		
		if missionRoll < 40:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/MappingMission.tscn"))
			pass # Mapping
		elif missionRoll < 50:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/FOBMission.tscn"))
			pass # FOB
		elif missionRoll < 60:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/FOBMission.tscn"))
			pass # Building Relays
		elif missionRoll < 70:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/SupplyRunMission.tscn"))
			pass # supply runs
		elif missionRoll < 80:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/NatureExperimentsMission.tscn"))
			pass # nature experiments
		elif missionRoll < 90:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/BoundaryEnforcmentMission.tscn"))
			pass # Boundary enforcment
		elif missionRoll < 100:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/ColoneyCreationMission.tscn"))
			pass # Coloney Creation
		elif missionRoll < 110:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/TerraformingMission.tscn"))
			pass # Terraforming
		elif missionRoll < 130:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/PirocyCrackdownMission.tscn"))
			pass # Pirocy Crackdown
		elif missionRoll < 140:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/LawEnforcmentMission.tscn"))
			pass # law enforcment
		elif missionRoll < 150:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/DisastorRecoveryMission.tscn"))
			pass # Disastor recovery
		elif missionRoll < 160:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/MedicalAidMission.tscn"))
			pass # medical aid
		elif missionRoll < 170:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/FieldTestsMission.tscn"))
			pass # field tests
		elif missionRoll < 180:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/VIPMission.tscn"))
			pass # VIP transport
		elif missionRoll < 190:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/StationBuildingMission.tscn"))
			pass # Station Building
		elif missionRoll < 200:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/NaturalSurveyMission.tscn"))
			pass # natural survey
		elif missionRoll < 210:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/AssistInResearchMission.tscn"))
			pass # Assist in research
		elif missionRoll < 220:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/NatureReclamationMission.tscn"))
			pass #  nature reclamation
		elif missionRoll < 230:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/SpaceElevatorHangingMission.tscn"))
			pass # space elevator hanging
		elif missionRoll < 240:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/BigDisastorRecoveryMission.tscn"))
			pass # big disastor recovery
		elif missionRoll < 270:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/VIPMission.tscn"))
			pass # VIP transport
		elif missionRoll < 300:
			create_mission(preload("res://RegionComponents/DevelopmentComp/Missions/CriminalInterceptMission.tscn"))
			pass # Criminal interception 
		else:
			print_debug("rolled higher than 300 on mission gen chart")
		
func create_mission(missionScene):
	var mission = missionScene.instance()
	mission.init(myRegion)
	missionComp.add_mission(myRegion.id, mission)
