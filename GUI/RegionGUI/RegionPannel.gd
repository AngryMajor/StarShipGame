extends Control


onready var RegionComp
onready var missionComp : MissionComp
var my_region


func init(region_data:Region):
	RegionComp = GameState.world.regionMap
	missionComp = GameState.world.get_componnet("MissionComp") as MissionComp
	my_region = region_data
	_update_mission_count()
	$HBoxContainer/NameLabel.text = region_data.name
	missionComp.connect("data_updated",self,"_on_mission_data_updated")
	GameState.connect("time_progressed",self,"_on_time_progressed")

func get_missions_func(coord):
	if missionComp.mission_at(coord) != null:
		return missionComp.mission_at(coord)
	
func _on_mission_data_updated(coord):
	if RegionComp.get_region_for(coord) == my_region:
		_update_mission_count()
		
func _on_time_progressed(amount):
	_update_mission_count()
	
func _update_mission_count():
	var missions_in_region = my_region.map_coords_in(funcref(self,"get_missions_func"))
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
