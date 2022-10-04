extends Node

func _ready():
	$MissionGenerator.connect("new_mission_available",self,"on_new_mission")
	call_deferred("asign_mission_to",0,$MissionGenerator.generate_new_mission())
	call_deferred("asign_mission_to",1,$MissionGenerator.generate_new_mission())
	call_deferred("asign_mission_to",2,$MissionGenerator.generate_new_mission())
	

func set_num_entities(num):
	$MissionGenerator.set_num_entities(num)
	for child in $MissionList.get_children():
		child.queue_free()
		
	for i in range(num):
		$MissionList.add_child(Node.new())

func _subscribe_to_signals(mission):
	pass
	
func asign_mission_to(region_id, mission):
	_subscribe_to_signals(mission)
	$MissionList.get_child(region_id).add_child(mission)
	
	var slot = $"../../".get_region(region_id).request_visual_slot(mission) #TODO: fix
	mission.assign_slot(slot)

	
func get_missions_in(region_id):
	return $MissionList.get_child(region_id).get_children()
