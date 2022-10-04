extends Control

onready var RegionComp
var my_region

func init(region_data:Region):
	RegionComp = GameState.world.get_componnet("RegionComp")
	my_region = region_data
	RegionComp.connect("data_updated",self,"_update_mission_count")
	$HBoxContainer/NameLabel.text = region_data.name
	_update_mission_count()

func _update_mission_count():
	var missionComp = RegionComp.get_componnet("MissionComp")
	var missions_in_region = missionComp.get_missions_in(my_region.id)
	for child in $VBoxContainer.get_children():
		child.queue_free()
	for mission in missions_in_region:
		var box = Container.new()
		box.rect_min_size.y = 15
		var lable = Label.new()
		lable.text = mission.name
		box.add_child(lable)
		var lable2 = Label.new()
		lable2.rect_position.x = 150
		lable2.text = String(mission.time_limit)
		box.add_child(lable2)
		$VBoxContainer.add_child(box)
