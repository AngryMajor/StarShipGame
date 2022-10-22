extends Control

export(PackedScene) var missionCard : PackedScene

export(NodePath) var _MissionList
onready var missionList = get_node(_MissionList)
onready var missionComp = GameState.world.get_componnet("MissionComp")

func _ready():
	updated_mission_lists(null)
		
	missionComp.connect("data_updated",self,"updated_mission_lists")
		
func updated_mission_lists(coord):
	for child in $ScrollContainer/VBoxContainer.get_children():
		$ScrollContainer/VBoxContainer.remove_child(child)
		child.queue_free()
	
	for mission in missionList.get_children():
		add_mission(mission)
	
func add_mission(mission):
		var card = missionCard.instance()
		card.init(mission)
		$ScrollContainer/VBoxContainer.add_child(card)
