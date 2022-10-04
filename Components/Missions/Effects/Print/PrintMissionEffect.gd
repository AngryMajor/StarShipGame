extends BaseEffect

class_name PrintMissionEffect

export(String) var text = ""

func trigger(mission):
	.trigger(mission)
	print_debug(text +" "+ mission.name)
