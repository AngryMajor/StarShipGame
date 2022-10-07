extends Node

export var mission_to_generate : PackedScene
export var Mission_Comp : NodePath
onready var missionComp = get_node(Mission_Comp)

func _unhandled_input(event):
	if event is InputEventKey and event.scancode == KEY_SPACE and event.is_pressed() == true:
		var region_index = rand_range(0,6)
		missionComp.add_mission(region_index, gen_mission())

func gen_mission():
	var mission = mission_to_generate.instance()
	return mission
